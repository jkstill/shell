#!/usr/bin/env bash

# trim whitespace from beginning and end of string using a regular expression

trim () {
	typeset -n string=$1
	# check if the string has leading and trailing whitespace
	# if it does, remove it
	# the regular expression is:
	# ^[[:space:]]*(.*[^[:space:]])[[:space:]]*$
	# ^[[:space:]]* - zero or more whitespace characters at the beginning
	# (.*[^[:space:]]) - any characters followed by a non-whitespace character
	# [[:space:]]*$ - zero or more whitespace characters at the end
	# the non-whitespace character is captured in the second element of BASH_REMATCH
	if [[ $string =~ ^[[:space:]]*(.*[^[:space:]])[[:space:]]*$ ]]; then
		string=${BASH_REMATCH[1]}
	fi
	#echo "number of elements in BASH_REMATCH = ${#BASH_REMATCH[@]}"
	#for i in "${!BASH_REMATCH[@]}"; do
		#echo "BASH_REMATCH[$i] = |${BASH_REMATCH[$i]}|"
	#done
}

s="   hello world   "
echo "|$s|"
trim s
echo "|$s|"

s="hello world   "
echo "|$s|"
trim s
echo "|$s|"

s="   hello world"
echo "|$s|"
trim s
echo "|$s|"

