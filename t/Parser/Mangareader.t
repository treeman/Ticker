#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;
use File::Basename;
use File::Slurp;
use DateTime;

my $module_name = "Ticker::Parser::Mangareader";
require_ok ($module_name);

my $o = $module_name->new();

my $file = dirname(__FILE__) . "/data/mangareader_site.html";
ok (-e $file, "Site file exists.");

my $site_str = read_file ($file);
isnt ($site_str, "", "Something in file.");

is_deeply ($o->_parse_latest ({}, $site_str),
    {
        historysstrongestdisciplekenichi => {
            name => "Historys Strongest Disciple Kenichi",
            chapter => 511,
            link => "http://mangareader.net/historys-strongest-disciple-kenichi/511",
            type => "manga",
            date => "2013-12-01T00:00:00",
        },
        'fairytail' => {
            'link' => 'http://mangareader.net/fairy-tail/320',
            'name' => 'Fairy Tail',
            'chapter' => 320,
            'type' => 'manga',
            date => "2013-05-31T00:00:00",
        },
        'magician' => {
            'link' => 'http://mangareader.net/magician/258',
            'name' => 'Magician',
            'chapter' => 258,
            'type' => 'manga',
            date => DateTime->today(),
        },
        'karateshoukoushikohinataminoru' => {
            'link' => 'http://mangareader.net/karate-shoukoushi-kohinata-minoru/195',
            'name' => 'Karate Shoukoushi Kohinata Minoru',
            'chapter' => 195,
            'type' => 'manga',
            date => "2013-03-03T00:00:00",
        },
        'kurogane' => {
            'link' => 'http://mangareader.net/kurogane/55',
            'name' => 'Kurogane',
            'chapter' => 55,
            'type' => 'manga',
            date => "2013-07-12T00:00:00",
        },
        'thebreakernewwaves' => {
            'link' => 'http://mangareader.net/the-breaker-new-waves/106',
            'name' => 'The Breaker: New Waves',
            'chapter' => 106,
            'type' => 'manga',
            date => "2013-01-09T00:00:00",
        },
        towerofgod => {
            link => "http://mangareader.net/tower-of-god/133",
            name => 'Tower of God',
            chapter => 133,
            type => 'manga',
            date => DateTime->today->subtract( days => 1 ),
        },
    },
    "From site."
);

done_testing();

