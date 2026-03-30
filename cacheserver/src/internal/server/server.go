package server

import (
	"context"
	"net/http"

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

	s.server = &http.Server{
		Handler: mux,
	}

	return s
}

func (s *Server) setRoutes(mux *http.ServeMux) {
	mux.HandleFunc("PUT /objects/{key}", s.handlePut)
	mux.HandleFunc("GET /objects/{key}", s.handleGet)
	mux.HandleFunc("DELETE /objects/{key}", s.handleDelete)
	mux.HandleFunc("GET /probe/liveness", s.liveness)
	mux.HandleFunc("GET /probe/readiness", s.readiness)
	mux.HandleFunc("GET /metrics", s.metrics)
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
