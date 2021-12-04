#! perl

use strict;
use warnings;

my $in_file = "../../../input_test.txt";

use lib "..";
use Bingo qw(calculate_bingo_score);

use Test::More tests => 1;

is( calculate_bingo_score( input_file => $in_file ),
    4512, sprintf( "Calculating values from input %s", $in_file ) );
