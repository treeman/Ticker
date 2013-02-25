#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;

my $module_name = "Ticker::Parser::Mangastream";
require_ok ($module_name);

my $o = $module_name->new();

my $feed_str = <<END;
<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
    <channel>
        <item>
            <title>History's Strongest Disciple Kenichi 511</title>
            <link>http://mangastream.com/read/hsdk/96108457/1</link>
            <pubDate>Fri, 22 Feb 2013 08:35:14 -0800</pubDate>
            <description>Fly!</description>
            <guid isPermaLink="true">http://mangastream.com/read/hsdk/96108457/1</guid>
        </item>

        <item>
            <title>Fairy Tail 320</title>
            <link>http://mangastream.com/read/fairy_tail/74394704/1</link>
            <pubDate>Fri, 22 Feb 2013 03:32:34 -0800</pubDate>
            <description>Fierce Lightning</description>
            <guid isPermaLink="true">http://mangastream.com/read/fairy_tail/74394704/1</guid>
        </item>

        <item>
            <title>One Piece 699</title>
            <link>http://mangastream.com/read/one_piece/12623735/1</link>
            <pubDate>Wed, 20 Feb 2013 08:07:57 -0800</pubDate>
            <description>The Morning Paper</description>
            <guid isPermaLink="true">http://mangastream.com/read/one_piece/12623735/1</guid>
        </item>
    </channel>
</rss>

END

is_deeply ($o->_parse ({}, $feed_str),
    {
        fairytail => {
            name => "Fairy Tail",
            chapter => 320,
            link => "http://mangastream.com/read/fairy_tail/74394704/1",
            date => "2013-02-22T03:32:34",
            type => "manga",
        },
        historysstrongestdisciplekenichi => {
            name => "History's Strongest Disciple Kenichi",
            chapter => 511,
            link => "http://mangastream.com/read/hsdk/96108457/1",
            date => "2013-02-22T08:35:14",
            type => "manga",
        },
        onepiece => {
            name => "One Piece",
            chapter => 699,
            link => "http://mangastream.com/read/one_piece/12623735/1",
            date => "2013-02-20T08:07:57",
            type => "manga",
        },
    },
    "From feed."
);

is_deeply (
    $o->_parse (
        {
            fairytail => {
                name => "Fairy Tail",
                chapter => 322,
            },
            onepiece => {
                name => "One Piece",
                chapter => 2,
            },
        },
        $feed_str
    ),
    {
        fairytail => {
            name => "Fairy Tail",
            chapter => 322,
        },
        historysstrongestdisciplekenichi => {
            name => "History's Strongest Disciple Kenichi",
            chapter => 511,
            link => "http://mangastream.com/read/hsdk/96108457/1",
            date => "2013-02-22T08:35:14",
            type => "manga",
        },
        onepiece => {
            name => "One Piece",
            chapter => 699,
            link => "http://mangastream.com/read/one_piece/12623735/1",
            date => "2013-02-20T08:07:57",
            type => "manga",
        },
    },
    "Update existing."
);

done_testing();

