package twheel

import (
	"context"
	"time"
)

type gate[V any] struct {
	c chan *Event[V]
	e *Event[V]
}

type handler[V any] struct {
	wheel *wheel[V]
	clock *clock

	put   chan *Event[V]
	del   chan *Event[V]
	ready chan *Event[V]

	out gate[V]

	cancel context.CancelFunc
	done   chan struct{}
}

func (h *handler[V]) mainLoop(ctx context.Context) {
	// defer close(h.ready) // eternal question: close or not to close?

	for {
		h.evalOutGate()
		select {
		case e := <-h.put: // 1. new event comes from user
			h.wheel.put(e)
		case e := <-h.del: // 2. user asks for a cancelation
			h.wheel.del(e)
		case ok := <-h.clock.c: // 3. tick happened or we've forced next work
			if ok {
				h.wheel.advance(time.Now())
			}
			if ok = h.wheel.step(); ok {
				h.clock.force()
			}
		case h.out.c <- h.out.e: // 4. successfully sent an event
			sended := h.wheel.getReady()
			h.wheel.del(sended)
			sended.dead.Store(true) // !invariant: sended == false
		case <-ctx.Done(): // 5. context was canceled
			close(h.done)
			return
		}
	}
}

func (h *handler[V]) evalOutGate() {
	firstReady := h.wheel.getReady()
	if firstReady == nil {
		h.out.c = nil
	} else {
		h.out.c = h.ready
		h.out.e = firstReady
	}
}

func newHandler[V any](ctx context.Context, props Props) *handler[V] {
	w := newWheel[V](props)
	childCtx, cancel := context.WithCancel(ctx)
	h := &handler[V]{
		wheel:  w,
		clock:  newClock(childCtx, props.Interval),
		put:    make(chan *Event[V]),
		del:    make(chan *Event[V]),
		ready:  make(chan *Event[V]),
		cancel: cancel,
		done:   make(chan struct{}),
	}

	go h.mainLoop(childCtx)
	return h
}
