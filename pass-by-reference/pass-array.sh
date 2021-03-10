#!/usr/bin/env bash

# pass single arg or array

shopt -s nocasematch

# modify referenced array

# try with printv -v as well

: <<'TYPESET'

'typeset' is being used rather than 'declare'

If the bash version is LT 4.3, 'declare -n' is not available

ksh93 has 'typset -n' which is the same as 'declare -n'.

'typeset -n' ia available in both ksh93 and bash 4.3

TYPESET

mmod () {
	typeset -n actualValArray=$1
	actualValArray[2]='Two'

}


mpass () {
	typeset returnType=$1
	typeset expectedVal=$2
	typeset actualVal 
	# var reference name - bash 4.3+
	typeset -n actualValArray

	# return 0 for success 1 for fail
	# default is fail
	typeset rc=1

	if [[ $returnType == 'string' ]]; then
		actualValArray=$3

		maxEl=${#actualValArray[@]}
		(( maxEl-- ))

		# read backwards as the string to match is likely near the end
		for i in $(seq $maxEl -1 0)
		do
			# this echo will cause an error if trying to capture the returncode
			#echo "i: " ${actualValArray[$i]}
			:
			[[ "${actualValArray[$i]}" =~ ^"$expectedVal"$ ]] && {
				rc=0
				break
			}
		done

		# add one element
		actualValArray[5]='five'

	else
		rc=1 # default fail
		actualVal=$3
		# this echo will cause an error if trying to capture the returncode
		#echo "Val: $actualVal"
		if [[ $actualVal =~ ^[[:digit:]]+ ]]; then
			[[ $actualVal -eq $expectedVal ]] && {
					rc=0
			}
		fi
	fi

	return $rc	
	
}


# Actual Data
typeset -a data

data[0]='zero'
data[1]='one'
data[2]='two'
data[3]='three'
data[4]='four'

typeset resultToCheck=42

# expected Data

expectedRC=42
expectedString='THREE'

#mpass string $expectedString data 
#echo rc: $?

#: << 'COMMENT'

echo
echo "These tests succeed"
echo 

if $( mpass string $expectedString data ); then
	echo "success for string of '$expectedString'"
else
	echo "FAILED for string of '$expectedString'"
fi

if $(mpass integer $expectedRC $resultToCheck); then
	echo "success for integer of '$expectedRC'"
else
	echo "FAILED for integer of '$expectedRC'"
fi

# fails
echo
echo "These tests fail"
echo 

expectedRC=95
expectedString='six'

##if $( mpass string $expectedString data ); then
mpass string $expectedString data

if [[ $? ]]; then
	echo "success for string of '$expectedString'"
else
	echo "FAILED for string of '$expectedString'"
fi

if $(mpass integer $expectedRC $resultToCheck); then
	echo "success for integer of '$expectedRC'"
else
	echo "FAILED for integer of '$expectedRC'"
fi

#COMMENT

typeset -a numbers

numbers[0]='zero'
numbers[1]='one'

echo 1: ${numbers[1]}
echo 2: ${numbers[2]}

mmod numbers

echo 2: ${numbers[2]}

echo 
echo "string array contents:"

for i in $(seq 0  ${#data[@]})
do
	echo "i: $i - ${data[$i]}"
done
