package storage

import (
	"context"
	"time"

	"github.com/rayskiy7/playground/cacheserver/pkg/cache"
)

type Dumper struct {
	cache    cache.Cache
	interval time.Duration
	stop     chan struct{}
	cancel   context.CancelFunc
	path     string
}

func NewDumper(i time.Duration, c cache.Cache, path string) *Dumper {
	d := &Dumper{
		cache:    c,
		interval: i,
		stop:     make(chan struct{}),
		path:     path,
	}
	return d
}

func (d *Dumper) Start(ctx context.Context) {
	childCtx, cancel := context.WithCancel(ctx)
	d.cancel = cancel
	go d.run(childCtx)
}

func (d *Dumper) Stop(ctx context.Context) {
	d.cancel()
	<-d.stop
	d.doDump(ctx)

}

func (d *Dumper) run(ctx context.Context) {
	ticker := time.NewTicker(d.interval)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			d.doDump(ctx)
		case <-ctx.Done():
			close(d.stop)
			return
		}
	}
}

func (d *Dumper) doDump(ctx context.Context) {
	data := d.cache.Dump(ctx)
	// open file...

	for {
		select {
		case chunk, ok := <-data:
			if !ok {
				return
			}
			_ = chunk // TODO: write chunk to file
		case <-ctx.Done():
			return
		}
	}
}
