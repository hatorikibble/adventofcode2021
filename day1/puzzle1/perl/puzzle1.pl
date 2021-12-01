#!/usr/bin/env perl

use strict;
use warnings;

my $in_file = "../../input_1.txt";

use lib "..";
use Puzzle1 qw(compare_measurements);

printf( "Found %d increases in input file %s\n",
    compare_measurements( input_file => $in_file ), $in_file );
