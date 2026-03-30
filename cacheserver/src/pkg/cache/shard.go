package cache

import (
	"context"
	"sync"
	"sync/atomic"
	"time"

	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

type entry struct {
	value   []byte
	expires time.Time
	size    int64
	event   *twheel.Event[string]
}

type shard struct {
	mu    sync.RWMutex
	items map[string]entry

	tw twheel.TimingWheel[string]

	length atomic.Int64
	size   atomic.Int64
}

func (s *shard) set(key string, value []byte, expires time.Time) (err error) {
	s.mu.Lock()
	defer s.mu.Unlock()

	if e, ok := s.items[key]; ok {
		s.length.Add(-1)
		s.size.Add(-e.size)
		_ = s.tw.Del(e.event)
	}

	e := entry{
		value:   value,
		expires: expires,
		size:    int64(len(value)),
	}
	if !expires.IsZero() {
		e.event, err = s.tw.Put(key, expires)
		if err != nil {
			return err
		}
	}
	s.items[key] = e
	s.length.Add(1)
	s.size.Add(e.size)

	return nil
}

func (s *shard) get(key string) ([]byte, bool) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	e, ok := s.items[key]
	if !ok {
		return nil, false
	}
	return e.value, true
}

func (s *shard) del(key string) {
	s.mu.Lock()
	defer s.mu.Unlock()

	if e, ok := s.items[key]; ok {
		s.length.Add(-1)
		s.size.Add(-e.size)
		delete(s.items, key)
		_ = s.tw.Del(e.event)
	}
}

func newShard(ctx context.Context, wg *sync.WaitGroup, wheelProps twheel.Props) *shard {
	s := &shard{
		items: make(map[string]entry),
		tw:    twheel.NewTimingWheel[string](ctx, wheelProps),
	}
	wg.Go(func() { s.expiredLoop(ctx) })
	return s
}

func (s *shard) expiredLoop(ctx context.Context) {
	ready := s.tw.Ready()
	for {
		select {
		case event := <-ready:
			s.mu.Lock()
			if entry, ok := s.items[event.V]; ok {
				if entry.event == event {
					s.length.Add(-1)
					s.size.Add(-entry.size)
					delete(s.items, event.V)
				}
			}
			s.mu.Unlock()
		case <-ctx.Done():
			return
		}
	}
}

func (s *shard) dump(ctx context.Context, out chan<- []byte) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	for key, e := range s.items {
		select {
		case out <- serializeRecord(record{key, e.value, e.expires}):
		case <-ctx.Done():
			return
		}
	}
}
