#!/usr/bin/env bash

setArray () {
	local arrayName="$1"
	local i=0
	
	eval "$arrayName[0]"="'this is 0'"
	eval "$arrayName[1]"="'this is 1'"

	return 0
}

showArray () {
	local arrayName="$1"[@];shift
	
	declare -a sArray
	sArray=("${!arrayName}")

	for val in "${sArray[@]}"
	do
		echo "val: $val"
	done

	return 0
}

declare -a testArray

setArray testArray

showArray testArray



