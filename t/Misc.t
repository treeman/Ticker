#!/usr/bin/env perl

use strict;
use warnings;
use 5.12.0;

use Test::More;

use Ticker::Misc;

is (make_id ("One Piece"), "onepiece", "Lower casing no space.");
is (make_id ("1234a12"), "a", "Remove numbers.");
is (make_id ("Let's Party!"), "letsparty", "Let's.");
is (make_id ("!#¤#()%()(#\"/'"), "", "Remove symbols");

done_testing();

