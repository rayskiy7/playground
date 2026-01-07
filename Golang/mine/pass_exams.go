// определяет пройден ли экзамен

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	input, err := reader.ReadString('\n')
	if err != nil {
		log.Fatal(err)
	}

	input = strings.TrimSpace(input)
	mark, err := strconv.ParseFloat(input, 64)
	if err != nil {
		log.Fatal(err)
	}

	if mark > 60 {
		fmt.Println("Yes")
	} else {
		fmt.Println("No")
	}
}
