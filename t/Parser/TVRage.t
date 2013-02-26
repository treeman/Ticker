#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;

my $module_name = "Ticker::Parser::TVRage";
require_ok ($module_name);

my $o = $module_name->new();

my $dexter = 'Show ID@7926
Show Name@Dexter
Show URL@http://www.tvrage.com/Dexter
Premiered@2006
Started@Oct/01/2006
Ended@
Latest Episode@07x12^Surprise, Motherf**ker!^Dec/16/2012
Next Episode@08x01^Season 8, Episode 1^Jun/30/2013
RFC3339@2013-06-30T21:00:00-5:00
GMT+0 NODST@1372636800
Country@USA
Status@Returning Series
Classification@Scripted
Genres@Crime | Drama
Network@Showtime
Airtime@Sunday at 09:00 pm
Runtime@60
';

is_deeply ($o->_parse ({}, $dexter),
    {
        dexter => {
            name => 'Dexter',
            latest => {
                date => "2012-12-16T00:00:00",
                season => 7,
                episode => 12,
            },
            type => 'tv',
        },
    },
    "Dexter info.",
);

my $big_bang = 'Show ID@8511
Show Name@The Big Bang Theory
Show URL@http://www.tvrage.com/The_Big_Bang_Theory
Premiered@2007
Started@Sep/24/2007
Ended@
Latest Episode@06x17^The Monster Isolation^Feb/21/2013
Next Episode@06x18^The Contractual Obligation Implementation^Mar/07/2013
RFC3339@2013-03-07T20:00:00-5:00
GMT+0 NODST@1362700800
Country@USA
Status@Returning Series
Classification@Scripted
Genres@Comedy
Network@CBS
Airtime@Thursday at 08:00 pm
Runtime@30
';

is_deeply ($o->_parse ({}, $big_bang),
    {
        thebigbangtheory => {
            name => 'The Big Bang Theory',
            latest => {
                date => "2013-02-21T00:00:00",
                season => 6,
                episode => 17,
            },
            type => 'tv',
        },
    },
    "Big bang info.",
);

done_testing();

