#!/usr/bin/env bash

echo bashargs: $@

: << 'COMMENTS'
https://stackoverflow.com/questions/27765610/perl-inside-bash-how-to-call-perl-on-a-script-saved-in-a-string

./sh-getopts.sh instance sdfsf username scott
bashargs: instance sdfsf username scott
instance: sdfsf
username: scott


COMMENTS


getargs () {

	/usr/bin/env perl -x "$0" $@

	# the magic cookie must be at the beginning of the line

	echo  <<-'EOF' > /dev/null
#!/usr/bin/env perl

	#foreach my $i ( 0 .. $#ARGV ) {
		#print " $i: $ARGV[$i]\n";
	#}

	#print join(":\n",@ARGV),":\n";
	print "$ARGV[0]=$ARGV[1]\n";
	print "$ARGV[2]=$ARGV[3]\n";

	__END__

	EOF

}

for argPair in $(getargs $@)
do
	eval $argPair
done


echo instance: $instance
echo username: $username



