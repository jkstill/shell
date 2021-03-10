#!/bin/bash

: << 'DOC'

Pass the name of the variable without the $ and 
get the name and the value in the funcition

DOC

deref () {
	local __vn="$1"   # Name of variable 
	#echo name: $vn
	local __myresult='test value'
	if [[ "$__vn" ]]; then
		 eval $__vn="'$__myresult'"
	else
		echo "$__myresult"
	fi
}

assertNotNull () {
   local __varName="$1"
	# works in bash 4+
   local __value=${!__varName}

   if [[ -z $__value ]]; then
      echo
      echo "Assert failed - '$__varName' is empty"
      echo
      exit 1
   fi
}

message=''

deref message
echo "message: $message"

message2=$(deref)
echo "message2: $message2"

full='stuff'
empty=''

assertNotNull full
assertNotNull empty

