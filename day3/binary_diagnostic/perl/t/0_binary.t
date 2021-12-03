#! perl

use strict;
use warnings;

my $in_file = "../../../input_test.txt";

use lib "..";
use Binary qw(calculate_gamma_epsilon_rate calculate_life_support_rating);

use Test::More tests => 2;

is( calculate_gamma_epsilon_rate( input_file => $in_file ),
    198, sprintf( "Calculating values from input %s", $in_file ) );

is( calculate_life_support_rating( input_file => $in_file ),
    230, sprintf( "Calculating values - part 2 - from input %s", $in_file ) );
