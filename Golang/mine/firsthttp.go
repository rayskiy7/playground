package main

import (
	"fmt"
	"r7/web"
)

func main() {
	urls := []string{
		"https://example.com/",
		"https://golang.org/",
		"https://golang.org/doc",
	}
	channel := make(chan int)

	for _, url := range urls {
		go web.GetSize(url, channel)
	}
	for i := 0; i < len(urls); i++ {
		fmt.Println(<-channel)
	}
}
