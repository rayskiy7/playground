package server

import (
	"context"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/rayskiy7/playground/cacheserver/pkg/cache"
)

type Server struct {
	cache  cache.Cache
	server *http.Server
}

func New(c cache.Cache) *Server {
	s := &Server{
		cache: c,
	}

	mux := http.NewServeMux()
	s.setRoutes(mux)
	s.registerCustomMetrics()

	s.server = &http.Server{
		Handler: mux,
	}

	return s
}

func (s *Server) setRoutes(mux *http.ServeMux) {
	mux.HandleFunc("PUT /objects/{key}", s.handlePut)
	mux.HandleFunc("GET /objects/{key}", s.handleGet)
	mux.HandleFunc("DELETE /objects/{key}", s.handleDelete)

	mux.HandleFunc("GET /probes/liveness", s.liveness)
	mux.HandleFunc("GET /probes/readiness", s.readiness)

	mux.Handle("GET /metrics", promhttp.Handler())
}

func (s *Server) registerCustomMetrics() {
	promauto.NewGaugeFunc(
		prometheus.GaugeOpts{
			Name: "cache_elements_count",
			Help: "Current number of elements in the cache",
		},
		func() float64 { return float64(s.cache.Len()) },
	)

	promauto.NewGaugeFunc(
		prometheus.GaugeOpts{
			Name: "cache_bytes_size",
			Help: "Current size of the cache in bytes (payload only)",
		},
		func() float64 { return float64(s.cache.ByteSize()) },
	)
}

func (s *Server) Listen(addr string) error {
	s.server.Addr = addr
	if err := s.server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		return err
	}
	return nil
}

func (s *Server) Stop(ctx context.Context) error {
	return s.server.Shutdown(ctx)
}
