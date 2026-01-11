#!/usr/bin/env bash

# if the first argument is numeric, subtract 6 from it print the result
# the format is [number.decimal, ...
#

file='bash-spinners.cast'

while IFS= read -r line; do
	# the following regex is removing the comma that is in the data
	# the commas should be preserved
	if [[ $line =~ ^\[([0-9]+)(\..*)?(,)(.*) ]]; then
		num=${BASH_REMATCH[1]}
		rest=${BASH_REMATCH[2]}${BASH_REMATCH[3]}${BASH_REMATCH[4]}
		new_num=$((num - 5))
		echo "[${new_num}${rest}"
	else
		echo "$line"
	fi
done < "$file"



