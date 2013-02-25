use strict;
use warnings;
use 5.12.0;

package Ticker::Data;

use Exporter 'import';
our @EXPORT = qw(manga_list manga_config data_file data_dir cache_dir top_dir manga_id_list);

use File::Slurp;
use File::HomeDir;

use Ticker::Misc;

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

    my @list = read_file ($file, chomp => 1);
    return @list;
}

sub manga_id_list
{
    my @list = manga_list();

    my %ids;
    map { $ids{make_id ($_)} = 1; } @list;
    return %ids;
}

