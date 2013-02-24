#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Storable qw(store retrieve freeze thaw dclone);

#my %color = ('Blue' => 0.1, 'Red' => 0.8, 'Black' => 0, 'White' => 1);

#store(\%color, 'mycolors') or die "Can't store %a in mycolors!\n";

#my $colref = retrieve('mycolors');
#die "Unable to retrieve from mycolors!\n" unless defined $colref;
#printf "Blue is still %lf\n", $colref->{'Blue'};

#my $colref2 = dclone(\%color);

#my $str = freeze(\%color);
#printf "Serialization of %%color is %d bytes long.\n", length($str);
#my $colref3 = thaw($str);

my $info = {
    poke => "gruelmon",
    id => 2,
    data => {
        food => [1, 2, 3, 4, 5],
        asdf => "false",
    },
};

store ($info, 'poke.dat') or die $!;
my $stored = retrieve ('poke.dat') or die $!;

say $stored->{poke};
say $stored->{id};

