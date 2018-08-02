#!/bin/bash

# bash-regex.sh
# pattern matching of entire string in bash
#


x='87,212.5'
x='This is a sentence. This my friends, is another sentence.'
x='ABCD EG10'

echo
echo "======   String: $x"

echo
echo == Check for number
echo 

if [[ $x =~ ^[[:digit:].,]+$ ]]; then
	echo 'IS a number!'
else
	echo 'NOT a number!'
fi


echo
echo == Check for Alpha only
echo 

if [[ $x =~ ^[[:alpha:][:punct:]\ \	]+$ ]]; then
	echo 'IS character only!'
else
	echo 'NOT character only!'
fi


echo
echo == Check for AlphaNumeric 
echo 

if [[ $x =~ ^[[:alnum:][:punct:]\ \	]+$ ]]; then
	echo 'IS AlphaNumeric!'
else
	echo 'NOT AlphaNumeric!'
fi


echo
echo == Check for Hex 
echo 

if [[ $x =~ ^[[:xdigit:]\ ]+$ ]]; then
	echo 'IS Hex!'
else
	echo 'NOT Hex!'
fi




