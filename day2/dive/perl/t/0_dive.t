#! perl

use strict;
use warnings;

my $in_file = "../../../input_test.txt";

use lib "..";
use Dive qw(calculate_final_depth_horizontal calculate_final_depth_horizontal_with_aim);

use Test::More tests => 2;

is( calculate_final_depth_horizontal( input_file => $in_file ),
    150, sprintf( "Calculating values from input %s", $in_file ) );

is( calculate_final_depth_horizontal_with_aim( input_file => $in_file ),
        900, sprintf( "Calculating values part 2 from input %s", $in_file ) );
