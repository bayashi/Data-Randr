package Data::Randr;
use strict;
use warnings;
use Carp qw/croak/;
use Exporter 'import';
our @EXPORT_OK = qw/randr/;

our $VERSION = '0.01';

sub new {
    my ($class, %args) = @_;

    my $rate  = delete $args{rate};
    my $digit = delete $args{digit};

    bless {
        rate  => $rate,
        digit => $digit,
    }, $class;
}

sub rate  { $_[0]->{rate}  }
sub digit { $_[0]->{digit} }

sub randr {
    my ($self, $base, $rate, $digit);

    if (ref $_[0] eq __PACKAGE__) {
        ($self, $base, $rate, $digit) = @_;
        $rate  = $rate ? $rate : $self->rate;
        $digit = $digit ? $digit : $self->digit;
    }
    else {
        ($base, $rate, $digit) = @_;
    }

    croak "required rate(0 - 100) :".($rate || '') if !$rate || $rate < 0 || $rate > 100;

    my $splash = int( $base * ($rate/100) );
    my $result = $base - $splash + rand($splash*2+1*($digit ? 0 : 1));

    if ($digit) {
        return sprintf("%0.${digit}f", $result);
    }

    return int($result);
}

1;

__END__

=encoding UTF-8

=head1 NAME

Data::Randr - splash number


=head1 SYNOPSIS

    use Data::Randr;

    randr(10); # 9 - 11

    randr(10, 20); # 8 - 12

    randr(10, 20, 4); # 8 - 12.9999 down to 4 decimal places, ex. 8.6389


=head1 DESCRIPTION

Data::Randr gives splashing number for a cache expires.

=head1 METHOD

=head2 new(%args)

constractor

=head3 constract options

=head4 rate : int // 10 (require)

splashing rate(1 - 100)

=head4 digit : int // 0 (optional)

decimal number

=head2 randr($number[, $rate, $digit])

response splashed number


=head1 REPOSITORY

=begin html

<a href="http://travis-ci.org/bayashi/Data-Randr"><img src="https://secure.travis-ci.org/bayashi/Data-Randr.png?_t=1452165822"/></a> <a href="https://coveralls.io/r/bayashi/Data-Randr"><img src="https://coveralls.io/repos/bayashi/Data-Randr/badge.png?_t=1452165822&branch=master"/></a>

=end html

Data::Randr is hosted on github: L<http://github.com/bayashi/Data-Randr>

I appreciate any feedback :D


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
