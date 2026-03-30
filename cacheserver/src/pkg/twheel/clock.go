package twheel

import (
	"context"
	"fmt"
	"time"
)

type signal struct{}

type clock struct {
	st clockState

	// sends ok signal out:
	//   - 'true' if signals about tick
	//   - 'false' if is forced
	// !note: forced signals have priority over ticks
	c chan bool

	signals chan signal
	tck     *time.Ticker
}

type clockState = int
type clockFlag = int

const (
	cForced clockFlag = 1 << iota
	cTicked
)

func (c *clock) force() { // from other goroutine
	select {
	case c.signals <- signal{}:
	default:
	}
}

func (c *clock) mainLoop(ctx context.Context) {
	// defer close(c.c) — think better imitate ticker-like object, so commented
	defer c.tck.Stop()

	for {
		switch c.st {
		case 0:
			select {
			case <-c.signals:
				c.st |= cForced
			case <-c.tck.C:
				c.st |= cTicked
			case <-ctx.Done():
				return
			}

		case cForced:
			select {
			case <-c.tck.C:
				c.st |= cTicked
			case c.c <- false:
				c.st &^= cForced
			case <-ctx.Done():
				return
			}

		case cTicked:
			select {
			case <-c.signals:
				c.st |= cForced
			case c.c <- true:
				c.st &^= cTicked
			case <-ctx.Done():
				return
			}

		case cForced | cTicked:
			select {
			case c.c <- false:
				c.st &^= cForced
			case <-ctx.Done():
				return
			}

		default:
			panic(fmt.Sprintf("unexpected state in clock.st: %v", c.st))
		}
	}
}

func newClock(ctx context.Context, interval time.Duration) *clock {
	c := &clock{
		signals: make(chan signal, 1),
		c:       make(chan bool),
		tck:     time.NewTicker(interval),
		st:      0,
	}

	go c.mainLoop(ctx)
	return c
}
