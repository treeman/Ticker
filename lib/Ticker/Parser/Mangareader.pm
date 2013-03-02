use strict;
use warnings;
use 5.12.0;

package Ticker::Parser::Mangareader;

use LWP::Simple;
use XML::Feed;
use Mojo::DOM;
use Data::Dumper;
use DateTime;
use DateTime::Format::Strptime;

use Ticker::Misc;
use Ticker::Data;

sub new
{
    bless {}, shift;
}

sub update
{
    my ($self, $info) = @_;

    my $site = LWP::Simple::get "http://www.mangareader.net/latest";
    $self->_parse_latest ($info, $site);
}

sub _parse_latest
{
    my ($self, $info, $site) = @_;

    my $dom = Mojo::DOM->new ($site);

    # Only track manga we're interested in.
    my @interested = manga_list();

    for (@interested) {
        # Create href url
        s/ /-/g;
        my $id = lc ($_);

        for my $e ($dom->find ("a[href^=\"/$id\"]")->each)
        {
            next unless $e->{href} =~ /\d$/;

            my $date = $e->parent->parent->find(".c1")->first->text;
            my $dt;
            if ($date eq "Today") {
                $dt = DateTime->today();
            }
            elsif ($date eq "Yesterday") {
                $dt = DateTime->today->subtract( days => 1 );
            }
            elsif ($date =~ /^(\d+)\s+(.+)\s+(\d+)$/) {
                my $strp = DateTime::Format::Strptime->new (pattern => "%d %b %Y");
                $dt = $strp->parse_datetime ($date);
            }
            else {
                $dt = DateTime->today();
            }

            my $manga = {};

            my ($name, $chapter) = $e->text =~ /^(.+)\s+(\d+)$/;

            $manga->{name} = $name;
            $manga->{chapter} = $chapter;
            $manga->{link} = "http://mangareader.net" . $e->{href};
            $manga->{date} = $dt;
            $manga->{type} = "manga";

            my $store_id = make_id ($name);

            next unless $store_id;

            # Store if we have no previous record.
            if (!$info->{$store_id}) {
                $info->{$store_id} = $manga;
            }
            # Or if we found a new chapter.
            elsif ($info->{$store_id}->{chapter} < $manga->{chapter}) {
                $info->{$store_id} = $manga;
            }
        }
    }

    return $info;
}

1;

