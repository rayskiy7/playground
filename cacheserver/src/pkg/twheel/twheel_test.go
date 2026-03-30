package twheel

import (
	"context"
	"fmt"
	"sync"
	"sync/atomic"
	"testing"
	"time"
)

func TestTimingWheel_DefaultProps(t *testing.T) {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	NewTimingWheel[int](ctx, DefaultProps)
}

func TestTimingWheel_ProductionStress(t *testing.T) {
	const (
		numEvents    = 10_000
		workers      = 100
		testDuration = 5 * time.Second
	)

	ctx, cancel := context.WithTimeout(context.Background(), testDuration+2*time.Second)
	defer cancel()

	props := Props{
		Interval: 10 * time.Millisecond, // << cancel timeout
		NLevels:  4,
		NBuckets: 20,
		MaxTTL:   10 * time.Second,
	}

	tw := NewTimingWheel[int](ctx, props)

	var (
		planned   atomic.Int64
		deleted   atomic.Int64
		received  atomic.Int64
		startTime = time.Now()
	)

	go func() {
		for range tw.Ready() { // active draining there is!
			received.Add(1)
		}
	}()

	var wg sync.WaitGroup

	for workerID := range workers {
		wg.Add(1)
		go func() { // in each worker
			defer wg.Done()
			for j := range numEvents / workers { // events # for 1 worker
				offset := time.Duration(j*40) * time.Millisecond // + 10*time.Millisecond $$$
				expire := time.Now().Add(offset)

				event, err := tw.Put(workerID*100_000+j, expire)
				if err == nil {
					planned.Add(1)

					if j%2 == 0 {
						go func(e *Event[int], off time.Duration) {
							time.Sleep(off / 2)
							if err := tw.Del(e); err == nil {
								deleted.Add(1)
							}
						}(event, offset)
					}
				}

				time.Sleep(1 * time.Millisecond)
			}
		}()
	}

	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()

	doneMonitor := make(chan struct{})
	go func() {
		for {
			select {
			case <-ticker.C:
				p, d, r := planned.Load(), deleted.Load(), received.Load()
				fmt.Printf("[%.6dms] Planned: %d | Deleted: %d | Expected: %d | Received: %d\n",
					time.Since(startTime).Milliseconds(), p, d, p-d, r)
			case <-ctx.Done():
				return
			case <-doneMonitor:
				return
			}
		}
	}()

	wg.Wait()
	time.Sleep(testDuration - time.Since(startTime) + 1*time.Second)
	close(doneMonitor)

	finalPlanned := planned.Load()
	finalDeleted := deleted.Load()
	finalReceived := received.Load()
	expected := finalPlanned - finalDeleted

	fmt.Printf("\n📊 FINAL STATISTICS:\nPlanned: %d, Deleted: %d, Received: %d, Expected: %d\n",
		finalPlanned, finalDeleted, finalReceived, expected)

	if finalReceived != expected {
		t.Errorf("Mismatch! Diff: %d", finalReceived-expected)
	}
}
