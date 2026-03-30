package server

import (
	"io"
	"net/http"
	"time"

	"github.com/rayskiy7/playground/cacheserver/internal/settings"
	"github.com/rayskiy7/playground/cacheserver/pkg/twheel"
)

func (s *Server) handlePut(w http.ResponseWriter, r *http.Request) {
	key := r.PathValue("key")
	if key == "" {
		http.Error(w, "Key is required", http.StatusBadRequest)
		return
	}

	var expires time.Time
	if expHeader := r.Header.Get("Expires"); expHeader != "" {
		parsedTime, err := http.ParseTime(expHeader)
		if err != nil {
			http.Error(w, "Invalid Expires header format. Use RFC1123", http.StatusBadRequest)
			return
		}
		expires = parsedTime
	}

	bodyReader := http.MaxBytesReader(w, r.Body, int64(settings.MaxObjectSize))
	defer bodyReader.Close()

	value, err := io.ReadAll(bodyReader)
	if err != nil {
		http.Error(w, "Payload too large or unreadable", http.StatusRequestEntityTooLarge)
		return
	}

	if len(value) == 0 {
		http.Error(w, "Empty body", http.StatusBadRequest)
		return
	}

	err = s.cache.Set(key, value, expires)
	switch err {
	case nil:
		w.WriteHeader(http.StatusCreated)
	case twheel.ErrInvalidExpireTime:
		http.Error(w, "Invalid expire time", http.StatusBadRequest)
	default:
		http.Error(w, "Internal server error", http.StatusInternalServerError)
	}
}

func (s *Server) handleGet(w http.ResponseWriter, r *http.Request) {
	key := r.PathValue("key")
	if key == "" {
		http.Error(w, "Key is required", http.StatusBadRequest)
		return
	}

	value, _ := s.cache.Get(key)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write(value)
}

func (s *Server) handleDelete(w http.ResponseWriter, r *http.Request) {
	key := r.PathValue("key")
	if key == "" {
		http.Error(w, "Key is required", http.StatusBadRequest)
		return
	}

	s.cache.Delete(key)
	w.WriteHeader(http.StatusNoContent)
}

func (s *Server) liveness(w http.ResponseWriter, _ *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func (s *Server) readiness(w http.ResponseWriter, _ *http.Request) {
	if s.cache.IsDumped() {
		w.WriteHeader(http.StatusServiceUnavailable)
	} else {
		w.WriteHeader(http.StatusOK)
	}
}
