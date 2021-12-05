#! perl

use strict;
use warnings;

my $in_file = "../../../input_test.txt";

use lib "..";
use Hydrothermal qw(calculate_overlap);

use Test::More tests => 1;

is( calculate_overlap( input_file => $in_file ),
    5, sprintf( "Calculating values from input %s", $in_file ) );
