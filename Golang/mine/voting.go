package main

import (
	"fmt"
	"r7/datafile"
)

func main() {
	votes := map[string]int{}

	for _, name := range datafile.GetStrings("candidates.txt") {
		votes[name]++
	}

	for name, votes_count := range votes {
		fmt.Printf("%s: %d\n", name, votes_count)
	}
}
