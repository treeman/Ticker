use strict;
use warnings;
use 5.12.0;

package Ticker::Parser::Test;

sub new { bless {}, shift }

sub update
{
    my ($self, $info) = @_;

    # Add various information to $info here.
}

1;

