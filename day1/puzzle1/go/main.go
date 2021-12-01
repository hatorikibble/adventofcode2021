package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	input_file := "../../input_1.txt"
	fmt.Printf("Found %d increases in input file %s\n", compare_measurements(input_file), input_file)
}

// compare_measurements reads 'input_file' and checks values
func compare_measurements(input_file string) int {
	var measurements []string
	var m_old int
	increase := 0

	content, err := os.ReadFile(input_file)
	check(err)

	measurements = strings.Split(string(content), "\n")

	for _, m := range measurements {
		if len(m) > 0 {
			m_int, err := strconv.Atoi(m)
			if m_old != 0 {
				if m_int > m_old {
					increase++
				}
			}
			m_old = m_int
			check(err)
		}
	}

	return increase
}

// check panics if an error is detected
func check(e error) {
	if e != nil {
		panic(e)
	}
}
