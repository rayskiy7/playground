package cache

import (
	"context"
	"fmt"
	"io"
	"testing"
	"time"

	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

func TestCache_FullLifecycle(t *testing.T) {
	twheel.DefaultProps.Interval = 10 * time.Millisecond

	mainCtx, mainCancel := context.WithTimeout(context.Background(), 40*time.Second)
	defer mainCancel()

	shards := 8
	c1 := NewEmptyCache(mainCtx, shards, twheel.DefaultProps)

	start := time.Now()

	fmt.Printf("\nSCENARIO: FULL LIFECYCLE (Start: %s)\n", start.Format("15:04:05"))

	setWithBase := func(c Cache, key string, delta time.Duration) {
		var exp time.Time
		if delta > 0 {
			exp = start.Add(delta)
		} else if delta < 0 {
			exp = start.Add(delta)
		}
		_ = c.Set(key, []byte("payload"), exp)
	}

	// --- PHASE 1: FILL ---
	for i := 0; i < 100; i++ {
		setWithBase(c1, fmt.Sprintf("key_%d_eternal", i), 0)             // Eternal
		setWithBase(c1, fmt.Sprintf("key_%d_long", i), 10*time.Minute)   // Too long (10m alive)
		setWithBase(c1, fmt.Sprintf("key_%d_8s", i), 12*time.Second)     // Long
		setWithBase(c1, fmt.Sprintf("key_%d_4s", i), 6*time.Second)      // Short
		setWithBase(c1, fmt.Sprintf("key_%d_rotten", i), -1*time.Minute) // Rotten
	}

	// --- PHASE 2: DELETIONS ---
	time.Sleep(1 * time.Second)
	for _, suffix := range []string{"eternal", "long", "8s", "4s", "rotten"} {
		for i := 0; i < 20; i++ {
			c1.Delete(fmt.Sprintf("key_%d_%s", i, suffix))
		}
	}
	fmt.Printf("[T+1s] After deletions Len: %d\n", c1.Len())

	// --- PHASE 3: MIGRATION ---
	pr, pw := io.Pipe()
	go func() {
		defer pw.Close()
		for raw := range c1.Dump(mainCtx) {
			pw.Write(raw)
		}
	}()

	c2 := NewEmptyCache(mainCtx, shards, twheel.DefaultProps)
	_ = c2.FillFromImage(mainCtx, pr)
	c1.Stop(mainCtx)
	fmt.Printf("[T+2s] Migration OK. C2 Len: %d\n", c2.Len())

	// --- PHASE 4: MONITORING ---
	checkPoints := []struct {
		wait   time.Duration
		expect int
		msg    string
	}{
		{7 * time.Second, 240, "Group 4s should expire"},
		{14 * time.Second, 160, "Group 8s should expire"},
	}

	for _, cp := range checkPoints {
		sleepTime := time.Until(start.Add(cp.wait))
		if sleepTime > 0 {
			time.Sleep(sleepTime)
		}
		fmt.Printf("[~T+%v] C2 dynamics: Len=%d. %s\n", cp.wait, c2.Len(), cp.msg)
	}

	// FINAL
	finalLen := c2.Len()
	fmt.Printf("\nFINAL: %d records in cache\n", finalLen)

	if finalLen != 160 {
		t.Errorf("FAIL: Expected 160 (80 eternal + 80 long), got %d", finalLen)
	} else {
		fmt.Println("PERFECT! Timings aligned, delta preserved.")
	}
}
