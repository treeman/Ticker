#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;

my $module_name = "Ticker::Parser::Mangastream";
require_ok ($module_name);

my $o = $module_name->new();

# TODO test sites here.
#my $site = File::Slurp

pass ("ok");

done_testing();

