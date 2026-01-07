// Echo server on WebSocket protocol
package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/gorilla/websocket"
)

const (
	PORT       = ":8001"
	BUFFERSIZE = 1024
)

// Need for UP grade the HTTP conn to WS
// The part of gorilla's API
var upgrader = websocket.Upgrader{
	ReadBufferSize:  BUFFERSIZE,
	WriteBufferSize: BUFFERSIZE,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

// WARN: Errors ignored
func HandleHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Weclome! This site works on WS. Please visit <a href=/ws>/ws</a>")
}

// WARN: Errors igonred
func HandleWS(w http.ResponseWriter, r *http.Request) {
	ws, _ := upgrader.Upgrade(w, r, nil)
	defer ws.Close()
	handler(ws) // no need use 'go' statement, so net.http creates new goroutine automatically
}

func handler(ws *websocket.Conn) {
	for {
		mt, message, err := ws.ReadMessage()
		if err != nil {
			fmt.Println(err)
			break
		}
		err = ws.WriteMessage(mt, message)
		if err != nil {
			fmt.Println(err)
			break
		}
	}
}

// WARN: Errors ignored
func main() {
	mux := http.NewServeMux()
	server := &http.Server{
		Addr:         PORT,
		Handler:      mux,
		IdleTimeout:  10 * time.Second,
		ReadTimeout:  time.Second,
		WriteTimeout: time.Second,
	}
	mux.Handle("/", http.HandlerFunc(HandleHTTP))
	mux.Handle("/ws", http.HandlerFunc(HandleWS))
	server.ListenAndServe()
}
