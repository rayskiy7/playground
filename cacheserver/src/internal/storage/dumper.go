package storage

import (
	"bufio"
	"context"
	"log"
	"os"
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
	if d.path == "" {
		log.Printf("No env DUMPER_PATH set. Skip Dump\n")
		return
	}

	tmpPath := d.path + ".tmp"
	file, err := os.OpenFile(tmpPath, os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0644)
	if err != nil {
		log.Printf("Error opening file for dump: %v\n", err)
		return
	}

	writer := bufio.NewWriter(file)
	success := false

	defer func() {
		file.Close()
		if success {
			_ = os.Rename(tmpPath, d.path)
		} else {
			_ = os.Remove(tmpPath)
		}
	}()

	dataCh := d.cache.Dump(ctx)

	for {
		select {
		case chunk, ok := <-dataCh:
			if !ok {
				if err := writer.Flush(); err != nil {
					log.Printf("Error Flush()! Dump not stored: %v\n", err)
					return
				}
				if err := file.Sync(); err != nil {
					log.Printf("Error Sync()! Dump not stored: %v\n", err)
					return
				}
				success = true
				return
			}

			if _, err := writer.Write(chunk); err != nil {
				log.Printf("Error writing 1 chunk to file: %v\n", err)
				return
			}
		case <-ctx.Done():
			return
		}
	}
}

func (d *Dumper) LoadImage(ctx context.Context, c cache.Cache) {
	if d.path == "" {
		log.Printf("No env DUMPER_PATH set. Skip LoadImage\n")
		return
	}

	file, err := os.Open(d.path)
	if err != nil {
		if os.IsNotExist(err) {
			log.Printf("info: no dump file on start. Strating without dump!\n")
			return
		}
		log.Printf("Error opening file for load: %v\n", err)
		return
	}
	defer file.Close()

	reader := bufio.NewReader(file)

	if err := c.FillFromImage(ctx, reader); err != nil {
		log.Printf("Error filling cache from image: %v\n", err)
		return
	}
}
