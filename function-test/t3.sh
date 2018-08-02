#!/bin/bash

# do not use subshell
declare -A rVals

echo -n "test type: "

i=${1:?'loop iteration value?'}
shift

if [[ $# -gt 0 ]]; then
	d=0
	echo "base run"
else
	d=1
	echo "functional run"
fi

r() {
	rVals[$FUNCNAME]='jeremiah was a bullfrog'
}


[[ $d -gt 0 ]] && r

echo "i: $i"

while [[ $i -gt 0 ]]
do
	((i--))
	[[ $d -gt 0 ]] && r
done

echo "Value: " ${rVals['r']}

echo "i: $i"

