use strict;
use warnings;
use 5.12.0;

use File::Slurp;
use File::HomeDir;

my $top_dir = File::HomeDir->my_home . "/.ticker";
my $manga_list_file = "manga_list";

sub top_dir
{
    return $top_dir;
}

sub cache_dir
{
    return "$top_dir/cache";
}

sub data_dir
{
    return "$top_dir/data";
}

sub data_file
{
    return data_dir() . "/store.dat";
}

sub manga_config
{
    return top_dir() . "/$manga_list_file";
}

sub manga_list
{
    my $file = manga_config();

    return () unless -e $file;

    my @list = read_file ($file);
    return @list;
}

