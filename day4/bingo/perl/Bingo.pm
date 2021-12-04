package Bingo;

use strict;
use warnings;

use Data::Dumper;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK = qw/calculate_bingo_score/;

sub calculate_bingo_score {
    my %p      = @_;
    my @diag   = read_lines( $p{input_file} );
    my @draws  = split( /,/, $diag[0] );
    my @boards = ();
    my $score  = undef;

    @boards = @{ read_boards( input => \@diag ) };

    #print Dumper(@boards);

    foreach my $d (@draws) {

        #print "the number is $d  \n";
        for ( my $i = 0 ; $i <= $#boards ; $i++ ) {

            #print "checking board $i\n";
            foreach my $r ( @{ $boards[$i] } ) {

                #print "checking Row ".Dumper($r);
                foreach my $c ( @{$r} ) {
                    if ( $c->{v} == $d ) {

                        #        print "found  value $d in board $i\n";
                        $c->{s} = "true";
                    }
                }
            }
            if ( board_has_won( board => $boards[$i] ) eq 'true' ) {

                #print "board[$i] has won!";
                #print Dumper( $boards[$i] );
                return get_score( board => $boards[$i], number => $d );
            }

        }
    }

}

sub read_boards {
    my %p         = @_;
    my $boards    = undef;
    my $new_board = "true";
    my $i         = 0;
    my $b         = -1;

    foreach my $l ( @{ $p{input} } ) {
        next if ( $l =~ /,/ );    # first line
        if ( length($l) == 0 ) {

            #print "new board!\n";
            $new_board = "true";
            $b++;
            $i = 0;
            next;
        }
        elsif ( $l =~ /^\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/ ) {
            $new_board = "false";

            #    print "$1 $2 $3 $4 \n";
            $boards->[$b]->[$i]->[0] = { 'v' => $1, 's' => 'false' };
            $boards->[$b]->[$i]->[1] = { 'v' => $2, 's' => 'false' };
            $boards->[$b]->[$i]->[2] = { 'v' => $3, 's' => 'false' };
            $boards->[$b]->[$i]->[3] = { 'v' => $4, 's' => 'false' };
            $boards->[$b]->[$i]->[4] = { 'v' => $5, 's' => 'false' };
            $i++;
        }

        #print $l. "\n";
    }

    return $boards;
}

sub board_has_won {
    my %p     = @_;
    my $board = $p{board};
    my $found = "true";

    # check rows
    foreach my $r ( @{$board} ) {
        $found = "true";

        #print "checking Row ".Dumper($r);
        foreach my $c ( @{$r} ) {

            if ( $c->{s} eq "false" ) {
                $found = "false";
            }
        }

        # still true after all columns
        if ( $found eq 'true' ) {

            #print "winner row " . Dumper($r);
            return $found;
        }
    }

    #check columns
    for ( my $i = 0 ; $i <= 4 ; $i++ ) {
        $found = "true";
        for ( my $k = 0 ; $k <= 4 ; $k++ ) {

            if ( $board->[$i]->[$k]->{s} eq 'false' ) {

                #print "$i:$k" . $board->[$i]->[$k]->{s} . "\n";
                $found = "false";
            }

        }

        # still true after all rows
        if ( $found eq 'true' ) {

            #print "winner column $i" . Dumper($board);
            return $found;
        }
    }

    return "false";
}

sub get_score {
    my %p     = @_;
    my $board = $p{board};
    my $score = 0;

    # check rows
    foreach my $r ( @{$board} ) {

        #print "checking Row ".Dumper($r);
        foreach my $c ( @{$r} ) {

            if ( $c->{s} eq "false" ) {
                $score += $c->{v};
            }
        }

    }
    print "Score: " . $score . " " . $p{number} . "\n";
    return $score * $p{number};
}

1;
