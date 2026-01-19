#!/usr/bin/env bash

echo "declare -a ary=( the quick brown fox jumps over the lazy dog )"

declare -a ary=( the quick brown fox jumps over the lazy dog )

# show all words using a for loop
echo
echo "All words in the array:"
i=0
for word in "${ary[@]}"; do
	  printf "  %02d: %s\n"  $i $word
	  (( ++i ))
done

echo
echo "get the fourth word with parameter expansion"
word="${ary[@]:3:1}"
echo "The fourth word is: $word"
echo

echo "get the fifth sixth words with parameter expansion"
word="${ary[@]:4:2}"
echo "The fifth sixth words are: $word"
echo 

