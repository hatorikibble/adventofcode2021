#! perl

use strict;
use warnings;

my $in_file = "../../input_test.txt";

use lib "..";
use Puzzle1 qw(compare_measurements);

use Test::More tests => 1;

is( compare_measurements( input_file => $in_file ),
    7, sprintf( "Comparing measurements from %s", $in_file ) );
