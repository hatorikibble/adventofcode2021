package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	input_file := "../../input_1.txt"
	fmt.Printf("Found %d increases in input file %s\n", calculate_final_depth_horizontal(input_file), input_file)
}

// calculate_final_depth_horizontal
func calculate_final_depth_horizontal(input_file string) int {
	var lines []string
	var command []string
	forward := 0
	depth := 0

	content, err := os.ReadFile(input_file)
	check(err)

	lines = strings.Split(string(content), "\n")

	for _, l := range lines {
		// fmt.Printf("Line: %s\n",l)
		if len(l) > 0 {
			command = strings.Split(string(l), " ")
			// fmt.Printf("%s: %s\n",command[0],command[1])
			value, err := strconv.Atoi(command[1])
			check(err)

			if command[0] == "forward" {
				forward += value
			} else if command[0] == "up" {
				depth += value
			} else if command[0] == "down" {
				depth -= value
			} else {
				fmt.Printf("invalid input in line %s", l)
			}
		}
	}
	return Abs(depth) * forward
}

func Abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

// check panics if an error is detected
func check(e error) {
	if e != nil {
		panic(e)
	}
}
