package main

import (
	"testing"
)

// TestCheckMeasurements tests the check_measuremants function
func TestCheckMeasurements(t *testing.T) {
	input_file := "../../input_test.txt"
	exp := 7
	res := compare_measurements(input_file)

	if res != exp {
		t.Errorf("Expected %d, got %d instead.\n", exp, res)
	}

}
