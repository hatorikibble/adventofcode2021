package Binary;

use strict;
use warnings;

use Data::Dumper;

use Exporter 'import';
use File::Slurper 'read_lines';

our @EXPORT_OK = qw/calculate_gamma_epsilon_rate calculate_life_support_rating/;

sub calculate_gamma_epsilon_rate {
    my %p            = @_;
    my @diag         = read_lines( $p{input_file} );
    my $gamma        = undef;
    my $epsilon      = undef;
    my $gamma_values = ();
    my $i            = 0;

    foreach my $d (@diag) {

        $i = 0;
        foreach my $v ( split( //, $d ) ) {

            if ( defined( $gamma_values->[$i]->{$v} ) ) {
                $gamma_values->[$i]->{$v}++;
            }
            else {
                $gamma_values->[$i]->{$v} = 1;    # init
            }
            $i++;
        }

    }

    foreach my $b ( @{$gamma_values} ) {
        if ( $b->{0} > $b->{1} ) {
            $gamma .= "0";

            # epsilon is the reverse
            $epsilon .= "1";
        }
        else {
            $gamma .= 1;

            # epsilon is the reverse
            $epsilon .= "0";
        }
    }

    #printf("Gamma %s, Epsilon %s \n",$gamma,$epsilon);
    return oct( "0b" . $gamma ) * oct( "0b" . $epsilon );

}

sub calculate_life_support_rating {
    my %p        = @_;
    my @diag     = read_lines( $p{input_file} );
    my @tmp_diag = ();
    my $gamma    = undef;
    my $epsilon  = undef;

    @tmp_diag = @diag;

    for ( my $p = 0 ; $p <= length( $tmp_diag[0] ) ; $p++ ) {
        @tmp_diag =
          @{ reduce_diag( diag => \@tmp_diag, pos => $p, mode => "gamma" ) };
    }

    #printf("Gamma is %s\n",$tmp_diag[0]);
    $gamma = $tmp_diag[0];

    @tmp_diag = @diag;

    for ( my $p = 0 ; $p <= length( $tmp_diag[0] ) ; $p++ ) {
        @tmp_diag =
          @{ reduce_diag( diag => \@tmp_diag, pos => $p, mode => "epsilon" ) };
    }

    #printf("Epsilon is %s\n",$tmp_diag[0]);
    $epsilon = $tmp_diag[0];

    #    printf("Gamma %s, Epsilon %s \n",$gamma,$epsilon);
    return oct( "0b" . $gamma ) * oct( "0b" . $epsilon );

}

sub reduce_diag {
    my %p           = @_;
    my @return_diag = ();
    my $size        = scalar( @{ $p{diag} } );
    my $b           = undef;
    my $count       = undef;

    return $p{diag} if ( $size == 1 );

    #  printf("inspecting position %s, size is %d\n",$p{pos},$size);

    foreach my $d ( @{ $p{diag} } ) {
        $b = substr( $d, $p{pos}, 1 );

        #    printf ("pos: %d in item %s is %s\n",$p{pos},$d,$b);
        if ( defined( $count->{$b} ) ) {
            $count->{$b}++;
        }
        else {
            $count->{$b} = 1;
        }
    }

    if ( $p{mode} eq 'gamma' ) {
        if ( $count->{0} > $count->{1} ) {
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '0' } @{ $p{diag} };
        }
        elsif ( $count->{0} < $count->{1} ) {
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '1' } @{ $p{diag} };
        }
        elsif ( $count->{0} == $count->{1} ) {    # equal, keep 1
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '1' } @{ $p{diag} };
        }
    }
    elsif ( $p{mode} eq 'epsilon' ) {
        if ( $count->{0} < $count->{1} ) {
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '0' } @{ $p{diag} };
        }
        elsif ( $count->{0} > $count->{1} ) {
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '1' } @{ $p{diag} };
        }
        elsif ( $count->{0} == $count->{1} ) {    # equal, keep 0
            @return_diag =
              grep { substr( $_, $p{pos}, 1 ) eq '0' } @{ $p{diag} };
        }
    }

    return \@return_diag;
}

1;
