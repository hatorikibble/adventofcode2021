package main

import (
	"testing"
)

// TestCheckMeasurements tests the check_measuremants function
func TestCalculate(t *testing.T) {
	input_file := "../../input_test.txt"
	exp := 150
	res := calculate_final_depth_horizontal(input_file)

	if res != exp {
		t.Errorf("Expected %d, got %d instead.\n", exp, res)
	}

}
