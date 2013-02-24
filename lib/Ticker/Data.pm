use strict;
use warnings;
use 5.12.0;

use File::HomeDir;

my $top_dir = ".ticker";

sub cache_dir
{
    return File::HomeDir->my_home . "/$top_dir/cache/";
}

sub data_dir
{
    return File::HomeDir->my_home . "/$top_dir/data/";
}

sub data_file
{
    return data_dir() . "store.dat";
}

