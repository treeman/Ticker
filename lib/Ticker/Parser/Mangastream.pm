use strict;
use warnings;
use 5.12.0;

package Ticker::Parser::Mangastream;

use LWP::Simple;
use XML::Feed;

use Ticker::Misc;
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

    # Only track manga we're interested in.
    my %interested = manga_list();

    # Parse rss/atom feed and build manga info.
    my $feed = XML::Feed->parse (\$site);
    for ($feed->entries) {
        my $id = make_id ($_->title);

        next unless $interested{$id};

        my $manga = {};

        ($manga->{name}, $manga->{chapter}) = $_->title =~ /^(.+)\s+(\d+)$/;

        $manga->{link} = $_->link;
        $manga->{date} = $_->issued;
        $manga->{type} = "manga";

        # Store if we have no previous record.
        if (!$info->{$id}) {
            $info->{$id} = $manga;
        }
        # Or if we found a new chapter.
        elsif ($info->{$id}->{chapter} < $manga->{chapter}) {
            $info->{$id} = $manga;
        }
    }

    return $info;
}

1;

