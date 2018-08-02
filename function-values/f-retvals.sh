#!/bin/bash

declare -A rVals

ft () {
	rVals[$FUNCNAME]="this is a string"
}

fmult () {
	rVals[$FUNCNAME]=''
	typeset o1=$1
	typeset o2=$2
	typeset m
	(( m = o1 * o2 ))
	rVals[$FUNCNAME]=$m
}

fadd () {
	rVals[$FUNCNAME]=''
	typeset o1=$1
	typeset o2=$2
	typeset a
	(( a = o1 + o2 ))
	rVals[$FUNCNAME]=$a
}

fdiv () {
	rVals[$FUNCNAME]=''
	typeset o1=$1
	typeset o2=$2
	typeset d
	(( d = o1 / o2 ))
	rVals[$FUNCNAME]=$d
}



f() {
	echo 'jeremiah was a bullfrog'
}


fmult 6 7
fdiv 42 13
fadd 2 2

for f in "${!rVals[@]}"
do
	echo "$f" 
done | sort | while read key
do
	echo "$key : ${rVals[$key]}"
done



