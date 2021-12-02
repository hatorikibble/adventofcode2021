package Dive;

use strict;
use warnings;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK =
  qw/calculate_final_depth_horizontal calculate_final_depth_horizontal_with_aim/;

sub calculate_final_depth_horizontal {
    my %p         = @_;
    my @movements = read_lines( $p{input_file} );
    my $forward   = 0;
    my $depth     = 0;

    foreach my $m (@movements) {
        if ( $m =~ /^forward\s(\d+)$/ ) {
            $forward += $1;
        }
        elsif ( $m =~ /^up\s(\d+)$/ ) {
            $depth += $1;
        }
        elsif ( $m =~ /^down\s(\d+)$/ ) {
            $depth -= $1;
        }
        else {
            die sprintf( "invalid input in line '%s' from file '%s'",
                $m, $p{input_file} );
        }
    }
    return abs($depth) * $forward;
}

sub calculate_final_depth_horizontal_with_aim {
    my %p         = @_;
    my @movements = read_lines( $p{input_file} );
    my $aim       = 0;
    my $forward   = 0;
    my $depth     = 0;

    foreach my $m (@movements) {
        if ( $m =~ /^forward\s(\d+)$/ ) {
            $forward += $1;
            $depth   += $aim * $1;
        }
        elsif ( $m =~ /^up\s(\d+)$/ ) {
            $aim -= $1;
        }
        elsif ( $m =~ /^down\s(\d+)$/ ) {
            $aim += $1;
        }
        else {
            die sprintf( "invalid input in line '%s' from file '%s'",
                $m, $p{input_file} );
        }

        # printf("Forward: %d, Depth: %d, aim: %d\n",$forward,$depth,$aim);
    }
    return abs($depth) * $forward;
}

1;
