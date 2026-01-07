package main

import (
	"bufio"
	"fmt"
	"net/url"
	"os"
	"os/signal"
	"strings"
	"syscall"

	"github.com/gorilla/websocket"
)

var commands = make(chan string)
var messages = make(chan string)
var signals = make(chan os.Signal, 1)

func init() {
	signal.Notify(signals, syscall.SIGINT)
}

/*
Эта горутина не будет нормально завершена и уйдёт в утечку!
Если после завершения работы WS-клиента требуется продолжить работу программы,
то необходимо зафиксить этот момент.
*/
func getInput() { // use go
	r := bufio.NewReader(os.Stdin)
	for {
		cmd, _ := r.ReadString('\n')
		commands <- strings.TrimSpace(cmd)
	}
}

func getMessages(ws *websocket.Conn) { // use go
	for {
		_, m, err := ws.ReadMessage()
		if err != nil {
			return
		}
		messages <- string(m)
	}
}

// WARN: Errors ignored
func main() {
	host, path := os.Args[1], os.Args[2]
	wsServer := url.URL{
		Scheme: "ws",
		Host:   host,
		Path:   path,
	}
	ws, _, _ := websocket.DefaultDialer.Dial(wsServer.String(), nil)
	defer ws.Close()

	go getInput()
	go getMessages(ws)

	for {
		select {
		case cmd := <-commands:
			ws.WriteMessage(websocket.TextMessage, []byte(cmd))
		case mes := <-messages:
			fmt.Printf("[MESSAGE]: %s\n", mes)
		case <-signals:
			_ = ws.WriteMessage(websocket.CloseMessage, websocket.FormatCloseMessage(websocket.CloseNormalClosure, ""))
			fmt.Println("Normal exiting")
			return
		}
	}
}
