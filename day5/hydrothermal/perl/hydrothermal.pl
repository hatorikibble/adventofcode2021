#!/usr/bin/env perl

use strict;
use warnings;

my $in_file = "../../input_1.txt";

use lib "..";
use Hydrothermal qw(calculate_overlap);

printf( "Calculating value from %s makes: %d\n",
    $in_file, calculate_overlap( input_file => $in_file ) );
