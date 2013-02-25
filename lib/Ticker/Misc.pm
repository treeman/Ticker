use strict;
use warnings;
use 5.12.0;

package Ticker::Misc;

use Exporter 'import';
our @EXPORT = qw(make_id);

sub make_id
{
    my $s = lc (shift);
    $s =~ s/[^a-z]//g;
    return $s;
}

1;

