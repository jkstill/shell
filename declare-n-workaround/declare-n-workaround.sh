#!/usr/bin/env bash

: << 'WORKAROUND'

'declare -n' is cool, but many systems have a Bash that it too old to use it

this workaround uses 'print -v' instead

WORKAROUND



f () {
	declare -n retVal=$1
	echo "f - varname: $1"
	echo "f - retVal: $retVal"
	retVal='This is a test!'
	echo "f - retVal: $retVal"
}


f2 () {
	#declare -n retVal=$1
	declare varname=$1

	echo "f2 - varname: $1"
	retVal='This is a test!'
	echo "f2 - retVal: $retVal"
	printf -v "$varname" "%s" "$retVal"
}


myVar='testing'

echo myVar: $myVar

f myVar

echo myVar: $myVar

echo "###################################"

myVar='testing'

echo myVar: $myVar

f2 myVar

echo myVar: $myVar

