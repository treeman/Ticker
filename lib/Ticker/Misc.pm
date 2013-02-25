use strict;
use warnings;
use 5.12.0;

package Ticker::Misc;

use Exporter 'import';
our @EXPORT = qw(make_id filter_info);

sub make_id
{
    my $s = lc (shift);
    $s =~ s/[^a-z]//g;
    return $s;
}

# Filter info pending on options.
sub filter_info
{
    my ($info, $options) = @_;

    # Sort by date latest first.
    my @entries = sort { $b->{date} <=> $a->{date} } values %$info;

    my @res;

    my $n = 0;
    for (@entries) {
        # Only save one type of entry.
        if ($options->{type}) {
            next unless $options->{type} eq $_->{type};
        }

        # Limit number of entries.
        last if $options->{limit} && $n++ >= $options->{limit};

        # Save it!
        push (@res, $_);
    }

    return @res;
}

1;

