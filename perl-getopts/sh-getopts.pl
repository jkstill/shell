#!/usr/bin/env perl

$TRUE = 1;
$FALSE = 0;

# ':' indicates optional arguments
# '=' indicates mandatory arguments
#		i = integer
#		n = integer
# 		f = fixed ( real ) numbers
# 		s = string
#		@ = array

# example getopts.prl -instance dv05 -username scott -debug
#

use Getopt::Long;

%optctl = ();

GetOptions(\%optctl,
	"instance=s",
	"username=s",
	"help",
	"debug!"
);


foreach $key ( keys %optctl ) {
	print "$key=$optctl{$key}\n";
}


