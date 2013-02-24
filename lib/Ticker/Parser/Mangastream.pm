use strict;
use warnings;
use 5.12.0;

package Ticker::Parser::Mangastream;

use LWP::Simple;
use XML::Feed;

use Ticker::Data;

sub new
{
    bless {}, shift;
}

sub update
{
    my ($self, $info) = @_;

    my $site = LWP::Simple::get "http://feeds.feedburner.com/mstream";
    $self->_parse ($info, $site);
}

sub _parse
{
    my ($self, $info, $site) = @_;

    my $feed = XML::Feed->parse (\$site);

    my @manga = ();
    for ($feed->entries) {
        # TODO search, kill and destroy here.
        my $e = {};
        $e->{title} = $_->title;
        $e->{link} = $_->link;
        my $dt = $_->issued;
        $e->{date} = $dt->datetime();
        push (@manga, $e);
    }

    $info->{manga} = \@manga;
}

1;

