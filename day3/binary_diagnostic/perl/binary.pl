#!/usr/bin/env perl

use strict;
use warnings;

my $in_file = "../../input_1.txt";

use lib "..";
use Binary
  qw(calculate_gamma_epsilon_rate calculate_life_support_rating);

printf( "Calculating value from %s makes: %d\n",
    $in_file, calculate_gamma_epsilon_rate( input_file => $in_file ) );

printf( "Calculating value - part 2 - from %s makes: %d\n",
        $in_file, calculate_life_support_rating( input_file => $in_file ) );
