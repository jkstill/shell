#!/usr/bin/env bash


[[ -z "$1" ]] && {

	echo 
	echo usage: remove-color-codes.sh $file
	echo 
	echo outut is on STDOUT
	echo
	exit 1
}

file=$1

[[ -f "$file" ]] || {
	echo
	echo "$file is not a file"
	echo
	exit 2
}

sed -Ee 's/\x1b\[[0-9]+\;[0-9]+m|\x1b\[[0-9]+\;[0-9]+\;[0-9]+m|\x1b\[0m|\x1b\][0-9]+\;//g' < $file

