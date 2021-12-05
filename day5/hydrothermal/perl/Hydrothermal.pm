package Hydrothermal;

use strict;
use warnings;

use Data::Dumper;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK = qw/calculate_overlap/;

my $board = ();

sub calculate_overlap {
    my %p       = @_;
    my @paths   = read_lines( $p{input_file} );
    my $x1      = undef;
    my $x2      = undef;
    my $y1      = undef;
    my $y2      = undef;
    my $overlap = 0;

    #init board
    for ( my $x = 0 ; $x < 1000 ; $x++ ) {
        for ( my $y = 0 ; $y < 1000 ; $y++ ) {
            $board->[$x]->[$y] = 0;
        }
        print "\n";
    }

    foreach my $p (@paths) {

        # 0,9 -> 5,9
        if ( $p =~ /^(\d+),(\d+).*?(\d+),(\d+)$/ ) {
            $x1 = $1;
            $y1 = $2;
            $x2 = $3;
            $y2 = $4;
            if ( ( $x1 == $x2 ) || ( $y1 == $y2 ) ) {
                printf( "Path '%s' is straight!\n", $p );
                fill_board( x1 => $x1, x2 => $x2, y1 => $y1, y2 => $y2 );
            }
        }
    }

    #print board
    #print "\n";
    for ( my $x = 0 ; $x < 1000 ; $x++ ) {
        for ( my $y = 0 ; $y < 1000 ; $y++ ) {

            #print $board->[$x]->[$y] . " ";
            $overlap++ if ( $board->[$x]->[$y] > 1 );
        }

        #print "\n";
    }

    return $overlap;

}

sub fill_board {
    my %p   = @_;
    my $tmp = undef;

    if ( $p{x1} == $p{x2} ) {
        printf( "fill row %d from %d to %d:", $p{x1}, $p{y1}, $p{y2} );

        # reverse?
        if ( $p{y1} > $p{y2} ) {
            print " - reverse -";
            $tmp   = $p{y1};
            $p{y1} = $p{y2};
            $p{y2} = $tmp;
        }
        for ( my $k = $p{y1} ; $k <= $p{y2} ; $k++ ) {
            printf( " %d/%d", $p{x1}, $k );
            $board->[ $p{x1} ]->[$k]++;

        }
        print "\n";
    }

    if ( $p{y1} == $p{y2} ) {
        printf( "fill column %d from %d to %d:", $p{y1}, $p{x1}, $p{x2} );

        # reverse?
        if ( $p{x1} > $p{x2} ) {
            print "- reverse -";
            $tmp   = $p{x1};
            $p{x1} = $p{x2};
            $p{x2} = $tmp;
        }

        for ( my $k = $p{x1} ; $k <= $p{x2} ; $k++ ) {
            printf( " %d/%d", $k, $p{y1} );
            $board->[$k]->[ $p{y1} ]++;

        }
        print "\n";
    }

}

1;
