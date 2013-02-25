use strict;
use warnings;
use 5.12.0;

package Ticker;

use File::Basename;
use File::Path;
use Storable qw(store retrieve);

use Ticker::Modules;
use Ticker::Data;

sub display_help
{
    my $name = basename($0);

    my $txt = <<END;
Usage:
    $name [options]

With options:

    -h,     --help                  Show this helpful text.
    -f,     --format [module]       Choose output format.
END

    say $txt;
};

sub update_info
{
    my $parser_dir = parser_dir();

    # List of all parser modules, for easy module calling.
    my @parsers;
    for my $module (list_modules ($parser_dir)) {
        my ($name, $file) = @$module;

        require $file;
        push (@parsers, "Ticker::Parser::$name"->new());
    }

    # Collect information.
    # TODO make it multithreaded.
    my $info = {};
    $_->update ($info) for @parsers;

    # Create data file path unless it exists.
    my $data_dir = data_dir();
    mkpath ($data_dir) unless -d $data_dir;

    # Save found data.
    store ($info, data_file());
}

sub display_info
{
    my ($options) = @_;

    my $output_format = $options->{format};

    my $data_file = data_file();
    unless (-e $data_file) {
        say "No data has been tracked.";
        exit;
    }

    # Load information from data file.
    my $info = retrieve ($data_file);

    my $printer_dir = printer_dir();

    # Find our printing module.
    my $printer;
    for my $module (list_modules ($printer_dir)) {
        my ($name, $file) = @$module;

        if ($name =~ /^\Q$output_format\E$/i) {
            require $file;

            $printer = "Ticker::Printer::$name"->new();
        }
    }

    die "No valid format for '$output_format' found!" unless $printer;

    # Output information.
    $printer->output ($info, $options);
}

sub clear_info
{
    my $data_file = data_file();
    if (-e $data_file) {
        unlink $data_file;
    }
}

1;

