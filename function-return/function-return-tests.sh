#!/usr/bin/env bash

set -up pipefail

# this function retures 0 if the number is even, and 1 if the number is odd
is_even() {
  local number=$1
  if (( number % 2 == 0 )); then
	 return 0
  else
	 return 1
  fi
}

# the same logic as above, but return true or false instead of 0 or 1
is_even_bool() {
  local number=$1
  if (( number % 2 == 0 )); then
	 return true
  else
	 return false
  fi
}


banner () {
	echo
	echo "==============================="
	echo "== $*"
	echo "==============================="
	echo
}


banner 'Testing is_even function'

for i in {1..10}; do

	num=$RANDOM

	if is_even $num; then
		echo "$num is even"
	else
		echo "$num is odd"
	fi
	
done


banner "Testing is_even_bool function with if/else: $num"

for i in {1..10}; do

	num=$RANDOM

	# the if statement fails because the return value is not a number, but a boolean value (true or false)
	if is_even_bool $num; then
		echo "$num is even"
	else
		echo "$num is odd"
	fi

done

banner "Testing is_even_bool function with [[]]: $num"

for i in {1..10}; do

	num=$RANDOM

	# this also fails as test [[]] expects an exit code
	[[ $(is_even_bool $num) == true ]] && echo "$num is even" || echo "$num is odd"

done


banner "Testing is_even_bool function without [[]]: $num"

for i in {1..10}; do

	num=$RANDOM

	$(is_even_bool $num) && echo "$num is even" || echo "$num is odd"

done


cat << EOF

In bash, functions can return an exit code (0 for success, non-zero for failure) or a string value.

The is_even function returns an exit code (0 for even, 1 for odd), which can be used in if statements or other conditional constructs.

The is_even_bool function attempts to return a boolean value (true or false), but this is not how bash functions work. 

The return statement in bash functions is used to set the exit code, not to return a value. 

Therefore, using return true or return false does not have the intended effect and can lead to unexpected behavior when trying to use the function in conditional statements.

Just stick with 0 for success, and GE 1 for failure when using return in bash functions, and use echo to output any string values if needed.

EOF

