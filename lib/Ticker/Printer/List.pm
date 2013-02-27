use strict;
use warnings;
use 5.12.0;

package Ticker::Printer::List;

use Data::Dumper;

use Ticker::Misc;

sub new { bless {}, shift }

sub output
{
    my ($self, $info, $options) = @_;

    my @entries = filter_info ($info, $options);
    for (@entries) {
        if ($_->{type} eq "manga") {
            say $_->{name} . " " . $_->{chapter};
        }
        elsif ($_->{type} eq "tv") {
            say $_->{name} . " " . $_->{latest}->{season} . "x" . $_->{latest}->{episode};
        }
        else {
            # TODO need some error reporting.
            say "???";
        }
    }
}

1;

