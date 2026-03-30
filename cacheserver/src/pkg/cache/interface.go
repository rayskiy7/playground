package cache

import (
	"context"
	"io"
	"time"

	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

type Cache interface {
	FillFromImage(ctx context.Context, r io.Reader) error

	Set(key string, value []byte, expires time.Time) error
	Get(key string) ([]byte, bool)
	Delete(key string)

	Len() int64
	ByteSize() int64

	Dump(context.Context) <-chan []byte
	IsDumped() bool
	Stop(context.Context)
}

func NewEmptyCache(ctx context.Context, shardsNumber int, wheelProps twheel.Props) Cache {
	return newShardedCache(ctx, shardsNumber, wheelProps)
}

func (c *shardedCache) FillFromImage(ctx context.Context, r io.Reader) error {
	start := time.Now()
	for record := range deserializeEntries(ctx, r) {
		if rottenExpirationTime(record.expires, start) {
			continue
		}
		if err := c.Set(record.key, record.value, record.expires); err != nil {
			return err
		}
	}
	return nil
}
