#$!/usr/bin/env bash

# pass hash name and display

showKV () {

	# pass entire hash by reference
	# requires bash 4.3+
	local -n arrayName="$1"

	for key in ${!arrayName[@]} 
	do
		echo "key: $key  val: ${arrayName[$key]} "
	done

	return 0
}


declare -A kv=( ['one']='Illinois' ['two']='Chetco' ['three']='Owyhee' )

showKV kv



