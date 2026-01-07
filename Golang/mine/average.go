package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"reflect"
	"strconv"
)

func werr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func readFloats(fileName string) []float64 {
	file, err := os.Open(fileName)
	werr(err)
	scanner := bufio.NewScanner(file)
	var result []float64
	for scanner.Scan() {
		f, err := strconv.ParseFloat(scanner.Text(), 64)
		werr(err)
		result = append(result, f)
	}
	err = file.Close()
	werr(err)
	werr(scanner.Err())
	return result
}

func main() {
	floats := readFloats("floats.txt")
	sum := 0.0
	for _, el := range floats {
		sum += el
	}
	fmt.Printf("%.2f\n", sum/float64(len(floats)))

	var a []int = []int{}
	fmt.Println(reflect.TypeOf(nil))
	fmt.Println(reflect.TypeOf(a))
	fmt.Println(reflect.TypeOf(math.Inf(-1)))
	fmt.Println(-math.Inf(1) == math.Inf(-1))
}
