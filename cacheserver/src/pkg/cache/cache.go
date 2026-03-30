package cache

import (
	"context"
	"sync"
	"sync/atomic"
	"time"

	"github.com/rayskiy7/playground/cacheserver/internal/settings"
	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

const (
	offset64 = 14695981039346656037
	prime64  = 1099511628211
)

type shardedCache struct {
	n       int
	shards  []*shard
	wg      sync.WaitGroup
	dumpers atomic.Int32

	cancel context.CancelFunc
}

func (c *shardedCache) hash(key string) uint64 {
	var h uint64 = offset64
	for i := 0; i < len(key); i++ {
		h ^= uint64(key[i])
		h *= prime64
	}
	return h % uint64(c.n)
}

func (c *shardedCache) Set(key string, value []byte, expires time.Time) error {
	return c.shards[c.hash(key)].set(key, value, expires)
}

func (c *shardedCache) Get(key string) ([]byte, bool) {
	return c.shards[c.hash(key)].get(key)
}

func (c *shardedCache) Delete(key string) {
	c.shards[c.hash(key)].del(key)
}

func (c *shardedCache) Len() int64 {
	var l int64
	for _, s := range c.shards {
		l += s.length.Load()
	}
	return l
}

func (c *shardedCache) ByteSize() int64 {
	var s int64
	for _, sh := range c.shards {
		s += sh.size.Load()
	}
	return s
}

func (c *shardedCache) Dump(ctx context.Context) <-chan []byte {
	out := make(chan []byte, settings.DumpBufSize)

	go func() {
		var wg sync.WaitGroup
		c.dumpers.Add(1)
		for _, sh := range c.shards {
			wg.Go(func() { sh.dump(ctx, out) })
		}
		wg.Wait()
		c.dumpers.Add(-1)
		close(out)
	}()

	return out
}

func (c *shardedCache) IsDumped() bool {
	return c.dumpers.Load() > 0
}

func (c *shardedCache) Stop(ctx context.Context) {
	c.cancel()

	done := make(chan struct{})
	go func() {
		c.wg.Wait()
		close(done)
	}()

	// may look strange, but what if all shards are deadlocked? we need alternative ctx
	select {
	case <-done:
		return
	case <-ctx.Done():
		return
	}
}

func newShardedCache(ctx context.Context, shardsNumber int, wheelProps twheel.Props) *shardedCache {
	childContext, cancel := context.WithCancel(ctx)
	c := &shardedCache{
		n:      shardsNumber,
		shards: make([]*shard, shardsNumber),
		cancel: cancel,
	}
	for i := range c.shards {
		c.shards[i] = newShard(childContext, &c.wg, wheelProps)
	}

	return c
}
