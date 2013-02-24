use strict;
use warnings;
use 5.12.0;

use File::Basename;

sub parser_dir
{
    return dirname (__FILE__)."/Parser";
}

sub printer_dir
{
    return dirname (__FILE__)."/Printer";
}

sub list_modules
{
    my $dir = shift;

    my @res;

    opendir (my $dh, $dir) or die "Couldn't open dir '$dir': $!";
    while (my $file = readdir ($dh)) {
        # Don't list hidden files, '.' or '..'.
        next if $file =~ /^\./;

        # Only look at perl module files.
        next if $file !~ /([^\/]+)\.pm$/;

        push (@res, [$1, "$dir/$file"]);
    }

    return @res;
}

1;

