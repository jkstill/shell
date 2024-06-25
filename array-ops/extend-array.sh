#!/usr/bin/env bash

set -u

declare -a ary=()

ary+=(one)
ary+=(two)
ary+=(three)

i=0
while [[ $i -lt ${#ary[@]} ]]
do
	echo "$i: ${ary[$i]}"
	(( i++ ))
done

