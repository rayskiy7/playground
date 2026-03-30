package twheel

import "time"

type table[V any] struct {
	buckets [][]bucket[V]
	expired bucket[V]
}

type indices struct {
	now time.Time

	L   int     // nLevels alias
	B   int     // nBuckets alias
	pow []int64 // precalc for B^0 B^1 B^2 ... B^(L-1)
	l   int     // current level
	b   []int   // current bucket (in each level)
}

type wheel[V any] struct {
	Props
	indices
	table[V]
}

func (w *wheel[V]) calcLevel(ticks int64) int {
	var l int
	for l = 1; l < w.L; l++ {
		if ticks < w.pow[l] {
			break
		}
	}
	return l - 1
}

func (w *wheel[V]) calcCoords(e *Event[V]) (level, bucket int) {
	ticks := int64(w.restrict(e.Ts).Sub(w.now) / w.Interval)
	l := w.calcLevel(ticks)
	b := int(ticks / w.pow[l])
	return l, b
}

func (w *wheel[V]) put(e *Event[V]) {
	l, b := w.calcCoords(e)
	if l == 0 && b == 0 {
		w.expired.put(e)
	} else {
		w.buckets[l][(w.b[l]+b)%w.B].put(e)
	}
}

func (w *wheel[V]) del(e *Event[V]) {
	if e.root == nil {
		return
	}
	e.root.del(e)
}

func (w *wheel[V]) curEvent() *Event[V] {
	return w.buckets[w.l][w.b[w.l]].head
}

func (w *wheel[V]) step() bool {
	for w.curEvent() == nil && w.l > 0 {
		w.l--
	}
	e := w.curEvent()
	if e == nil {
		return false
	}

	w.del(e)
	w.put(e)
	return true
}

func (w *wheel[V]) advance(now time.Time) {
	if w.curEvent() != nil {
		panic("wheel.advance is called, but current tick still has steps to do")
	}
	w.now = now

	for w.b[w.l]+1 == w.B && w.l < w.L-1 {
		w.b[w.l] = 0
		w.l++
	}
	w.b[w.l] = (w.b[w.l] + 1) % w.B
}

func (w *wheel[V]) getReady() *Event[V] {
	return w.expired.head
}

func newWheel[V any](props Props) *wheel[V] {
	w := &wheel[V]{
		props,
		indices{
			now: time.Now(),
			L:   props.NLevels,
			B:   props.NBuckets,
			pow: make([]int64, props.NLevels),
			l:   0,
			b:   make([]int, props.NLevels),
		},
		table[V]{
			buckets: make([][]bucket[V], props.NLevels),
		},
	}
	w.pow[0] = 1
	pow := int64(1)
	for i := 1; i < w.L; i++ {
		pow *= int64(w.B)
		w.pow[i] = pow
	}
	for i := range w.L {
		w.buckets[i] = make([]bucket[V], w.B)
	}
	return w
}
