#!/usr/bin/env perl

use strict;
use warnings;

my $ll = 20;
my $bs=chr(92);

for (my $i = 1; $i <= $ll+1; $i++) {
	my $p = '|' x ( ($ll - $i) + 1);
	my $s= $bs x ( 2 * ($i - 1));
	print qq{"$p$s",\n};
}

