#!/usr/bin/env bash

set -u

declare -a ary=()

#check if array is empty
[[ ${#ary[@]} -eq 0 ]] && echo "Array is empty"

ary+=(one)
ary+=(two)
ary+=(three)

[[ ${#ary[@]} -gt 0 ]] && echo "Array is not empty"

i=0
while [[ $i -lt ${#ary[@]} ]]
do
	echo "$i: ${ary[$i]}"
	(( i++ ))
done

echo
echo "Using for loop to iterate over array indices"
echo 

for i in ${!ary[@]}
do
	echo "$i: ${ary[$i]}"
done

