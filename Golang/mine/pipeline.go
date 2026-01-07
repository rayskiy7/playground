package main

import "fmt"

func main() {
	ints := make(chan int)
	squares := make(chan int)

	go func() {
		defer close(ints)
		for i := range 100 {
			ints <- i
		}
	}()

	go func() {
		defer close(squares)
		for el := range ints {
			squares <- el * el
		}
	}()

	for el := range squares {
		fmt.Println(el)
	}
}
