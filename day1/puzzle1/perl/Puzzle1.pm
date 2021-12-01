package Puzzle1;

use strict;
use warnings;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK = qw/compare_measurements/;

sub compare_measurements {
    my %p            = @_;
    my @measurements = read_lines( $p{input_file} );
    my $m_old        = undef;
    my $increase     = 0;

    foreach my $m (@measurements) {
        if ( defined($m_old) ) {
            if ( $m > $m_old ) {
                $increase++;
            }
        }
        $m_old = $m;
    }
    return $increase;
}

1;
