#!/usr/bin/env perl

use strict;
use warnings;

my $in_file = "../../input_1.txt";

use lib "..";
use Bingo qw(calculate_bingo_score);

printf( "Calculating value from %s makes: %d\n",
    $in_file, calculate_bingo_score( input_file => $in_file ) );
