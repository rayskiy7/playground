package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/rayskiy7/playground/cacheserver/internal/server"
	"github.com/rayskiy7/playground/cacheserver/internal/settings"
	"github.com/rayskiy7/playground/cacheserver/internal/storage"
	"github.com/rayskiy7/playground/cacheserver/pkg/cache"
)

func main() {
	rootCtx, cancel := context.WithCancel(context.Background())
	defer cancel()

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, os.Interrupt, syscall.SIGTERM)
	defer signal.Stop(sigs)

	cache := cache.NewEmptyCache(rootCtx, settings.ShardsNumber, settings.WheelProps())
	dumper := storage.NewDumper(settings.DumpInterval, cache, settings.ImagePath)
	dumper.LoadImage(rootCtx, cache)
	dumper.Start(rootCtx)

	server := server.New(cache)
	go func() {
		if err := server.Listen(settings.ServerAddress); err != nil {
			log.Printf("Server forced to shutdown: %v", err)
		}
	}()

	<-sigs
	endCtx, cancel := context.WithDeadline(rootCtx, time.Now().Add(29*time.Second))
	defer cancel()

	server.Stop(endCtx)
	dumper.Stop(endCtx)
	cache.Stop(endCtx)
}
