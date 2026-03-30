package twheel

import (
	"math"
	"sync/atomic"
	"time"
)

type Event[V any] struct {
	V  V
	Ts time.Time

	dead atomic.Bool

	// intrusive
	root *bucket[V]
	prev *Event[V]
	next *Event[V]
}

type bucket[V any] struct {
	head *Event[V]
}

func (b *bucket[V]) put(e *Event[V]) {
	e.root = b
	e.prev = nil
	e.next = b.head

	if b.head != nil {
		b.head.prev = e
	}

	b.head = e
}

func (b *bucket[V]) del(e *Event[V]) {
	if e.root != b {
		return
	}

	if e.prev != nil {
		e.prev.next = e.next
	} else {
		e.root.head = e.next
	}
	if e.next != nil {
		e.next.prev = e.prev
	}
	e.root = nil
	e.prev = nil
	e.next = nil
}

func assertProps(props Props) {
	mustBe := props.MaxTTL > 0 &&
		props.Interval > 0 &&
		props.NLevels >= 2 &&
		props.NBuckets >= 2 &&
		doesNotOverflowPow(props.NBuckets, props.NLevels) &&
		fitsSetMaxTTL(props.NBuckets, props.NLevels, props.Interval, props.MaxTTL)

	if !mustBe {
		panic("Invalid Props value")
	}
}

func doesNotOverflowPow(b, p int) bool {
	if b == 0 {
		return true
	}

	base := int64(b)
	var acc int64 = 1
	for i := 0; i < p; i++ {
		if acc > math.MaxInt64/base {
			return false // overflow
		}
		acc *= base
	}
	return true
}

func fitsSetMaxTTL(b, p int, interval, maxTTL time.Duration) bool {
	limit := int64(maxTTL / interval)

	base := int64(b)
	acc := int64(1)
	for range p {
		if acc >= limit {
			return true
		}
		if acc > math.MaxInt64/base {
			return true
		}
		acc *= base
	}

	return acc >= limit
}

func calcTicks(from, to time.Time, by time.Duration) int64 {
	return to.UnixNano()/by.Nanoseconds() - from.UnixNano()/by.Nanoseconds()
}
