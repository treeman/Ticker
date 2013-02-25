#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;
use File::Basename;
use File::Slurp;

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
            date => "2013-02-22T00:00:00",
            type => "manga",
        },
    },
    "From site."
);

#is_deeply (
    #$o->_parse (
        #{
            #fairytail => {
                #name => "Fairy Tail",
                #chapter => 322,
            #},
            #onepiece => {
                #name => "One Piece",
                #chapter => 2,
            #},
        #},
        #$site_str
    #),
    #{
        #fairytail => {
            #name => "Fairy Tail",
            #chapter => 322,
        #},
        #historysstrongestdisciplekenichi => {
            #name => "History's Strongest Disciple Kenichi",
            #chapter => 511,
            #link => "http://mangastream.com/read/hsdk/96108457/1",
            #date => "2013-02-22T08:35:14",
            #type => "manga",
        #},
        #onepiece => {
            #name => "One Piece",
            #chapter => 699,
            #link => "http://mangastream.com/read/one_piece/12623735/1",
            #date => "2013-02-20T08:07:57",
            #type => "manga",
        #},
    #},
    #"Update existing."
#);

done_testing();

