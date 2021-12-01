package Puzzle2;

use strict;
use warnings;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK = qw/compare_measurements/;

sub compare_measurements {
    my %p            = @_;
    my @measurements = read_lines( $p{input_file} );
    my $increase     = 0;
    my $triple       = undef;
    my $triple_old   = undef;

    for my $i ( 0 .. $#measurements ) {
        if ( $i >= 2 ) {
            $triple =
              $measurements[ $i - 2 ] +
              $measurements[ $i - 1 ] +
              $measurements[$i];
            if ( ( defined($triple_old) ) && ( $triple > $triple_old ) ) {
                $increase++;
            }
            $triple_old = $triple;
        }
    }
    return $increase;
}

1;
