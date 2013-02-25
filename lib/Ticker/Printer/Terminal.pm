use strict;
use warnings;
use 5.12.0;

package Ticker::Printer::Terminal;

use Data::Dumper;

sub new { bless {}, shift }

sub output
{
    my ($self, $info) = @_;

    my @entries = values %$info;

    @entries = sort { $b->{date} <=> $a->{date} } @entries;

    for (@entries) {
        if ($_->{type} eq "manga") {
            say $_->{name} . " " . $_->{chapter};
            #say "    " . $_->{date}->datetime();
        }
        else {
            say "??";
        }
    }
}

1;

