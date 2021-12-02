#!/usr/bin/env perl

use strict;
use warnings;

my $in_file = "../../input_1.txt";

use lib "..";
use Dive
  qw(calculate_final_depth_horizontal calculate_final_depth_horizontal_with_aim);

printf( "Calculating values from input %s makes: %d\n",
    $in_file, calculate_final_depth_horizontal( input_file => $in_file ) );
printf( "Calculating values part 2 from input %s makes: %d\n",
    $in_file,
    calculate_final_depth_horizontal_with_aim( input_file => $in_file ) );
