package main

import (
	"fmt"
	"time"
)

func ff() {
	for i := 0; i < 100; i++ {
		fmt.Print("f")
	}
}

func g() {
	for i := 0; i < 100; i++ {
		fmt.Print("g")
	}
}

func main() {
	go ff()
	go g()
	time.Sleep(3)
	fmt.Println("MAIN")
}
