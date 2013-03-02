use strict;
use warnings;
use 5.12.0;

package Ticker::Parser::TVRage;

use LWP::Simple;
use XML::Feed;
use Mojo::DOM;
use Data::Dumper;
use DateTime;
use DateTime::Format::Strptime;

use Ticker::Misc;
use Ticker::Data;

my $strp = DateTime::Format::Strptime->new (pattern => "%b/%d/%Y");

sub new
{
    bless {}, shift;
}

sub update
{
    my ($self, $info) = @_;

    my @series = tv_list();

    $self->_update_serie ($info, $_) for @series;
}

sub _update_serie
{
    my ($self, $info, $serie) = @_;

    my $response = LWP::Simple::get "http://services.tvrage.com/tools/quickinfo.php?show=$serie";

    $self->_parse ($info, $response);
}

sub _parse
{
    my ($self, $info, $site) = @_;

    my %h;
    for (split /^/, $site) {
        chomp;
        my ($descr, $val) = split /@/;
        $h{$descr} = $val;
    }

    my %tv;
    $tv{name} = $h{'Show Name'};
    my ($s, $ep, $title, $date) = $h{'Latest Episode'} =~ /^(\d+)x(\d+)\^([^^]+)\^(.+)$/;
    $tv{latest} = {
        date => $strp->parse_datetime ($date),
        season => $s + 0,
        episode => $ep + 0,
    };
    $tv{type} = 'tv';
    $tv{date} = $tv{latest}->{date};

    my $id = make_id ($tv{name});
    next unless $id;
    $info->{$id} = \%tv;

    return $info;
}

1;

