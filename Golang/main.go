package main

import "fmt"

const (
	min   = 2147483648
	max   = 2147483647
	space = 32
	minus = 45
	plus  = 43
	zero  = 48
	nine  = 57
)

func myAtoi(s string) int {
	var res int
	negative := false
	i := 0
loop:
	for ; i < len(s); i++ {
		bt := s[i]
		switch {
		case bt == space:
			continue
		case bt == minus:
			negative = true
			i++
			break loop
		case bt == plus:
			i++
			break loop
		case zero <= bt && bt <= nine:
			break loop
		default:
			return 0
		}
	}
	for ; i < len(s); i += 1 {
		bt := s[i]
		if !(zero <= bt && bt <= nine) {
			break
		}
		res = res*10 + int(bt-zero)
		if !negative && res > max {
			return 0
		}
		if negative && res > min {
			return 0
		}
	}
	if negative {
		return -res
	} else {
		return res
	}
}

func main() {
	fmt.Println(myAtoi(" w  -001d234"))
}
