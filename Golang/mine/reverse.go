package main

import "fmt"

func main() {
	reverse([]byte("Hello"))
}

func reverse(bytes []byte) {
	str := string(bytes)
	bytes[0] = 'h'
	fmt.Println(str)
	fmt.Println(string(bytes))
}
