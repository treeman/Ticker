use strict;
use warnings;
use 5.12.0;

package Ticker::Printer::Dumper;

use Data::Dumper;

sub new { bless {}, shift }

sub output
{
    my ($self, $info) = @_;

    say Dumper ($info);
}

1;

