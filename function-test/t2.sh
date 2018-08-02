#!/bin/bash


# use a subshell
RVAL=''

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

echo "RVAL: $RVAL"

r() {
	echo 'jeremiah was a bullfrog'
}

[[ $d -gt 0 ]] && RVAL=$(r)
echo "RVAL: $RVAL"

echo "i: $i"

while [[ $i -gt 0 ]]
do
	((i--))
	[[ $d -gt 0 ]] && RVAL=$(r)
done

echo "i: $i"

