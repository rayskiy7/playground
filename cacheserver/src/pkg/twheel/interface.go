/*
- thread-safe
- instant deletion (non-lazy)
- order of simultaneously ready events (unread yet) undetermined
- supports deletion status. You see if already deleted or sent
*/
package twheel

import (
	"context"
	"errors"
	"time"
)

var ErrInvalidExpireTime = errors.New("new event has expiration time in the past or in too far future")
var ErrNilEventDeletion = errors.New("nil event deletion is not allowed in TimingWheel.Del")
var ErrEventDead = errors.New("event dead: is canceled or is read")

type TimingWheel[V any] interface {
	Put(value V, expirationTime time.Time) (*Event[V], error)
	Del(event *Event[V]) error
	Ready() <-chan *Event[V]

	Stop()
}

var DefaultProps = Props{
	Interval: 250 * time.Millisecond,
	NLevels:  8,
	NBuckets: 100,
	MaxTTL:   24 * time.Hour * 1000, // ≈ 3 year
}

type Props struct {
	Interval time.Duration
	NLevels  int
	NBuckets int
	MaxTTL   time.Duration
}

func NewTimingWheel[V any](ctx context.Context, props Props) TimingWheel[V] {
	assertProps(props)
	return newHandler[V](ctx, props)
}

// IMPLEMENTATION =====================================================================

func (h *handler[V]) Put(v V, ts time.Time) (*Event[V], error) {
	now := time.Now() // ? may be optimized
	if ts.Before(now.Add(-time.Hour)) || ts.After(now.Add(h.wheel.MaxTTL)) {
		return nil, ErrInvalidExpireTime
	}
	e := &Event[V]{ // * MAIN ALLOCATION POINT (consider Pool, Prealloc, Limits, etc)
		V:  v,
		Ts: ts,
	}
	h.put <- e // blocks until wheel's accepted event to handle
	return e, nil
}

func (h *handler[V]) Del(e *Event[V]) error {
	if e == nil {
		return ErrNilEventDeletion
	}
	h.del <- e                               // if accepted, there isn't the event anymore, so no future send, so ...
	if !e.dead.CompareAndSwap(false, true) { // ... <- it's the place to kill atomically
		return ErrEventDead
	}
	return nil
}

func (h *handler[V]) Ready() <-chan *Event[V] {
	return h.ready
}

func (h *handler[V]) Stop() {
	h.cancel()
	<-h.done
}
