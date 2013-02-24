#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;
use File::HomeDir;

my $module_name = "Ticker::Data";
require_ok ($module_name);

my $top_dir = top_dir();
my $home_dir = File::HomeDir->my_home;
like ($top_dir, qr|^\Q$home_dir\E/|, "Top dir in home directory.");

my $manga_config = manga_config();
like ($manga_config, qr|^\Q$top_dir\E/|, "Manga config file inside home dir.");

if (-e $manga_config) {
    my @list = manga_list();

    ok (scalar @list, "If manga config file exists, shouldn't be empty.");
}

done_testing();

