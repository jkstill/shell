#$!/usr/bin/env bash

# pass hash name and display

showKV () {

	# cannot pass a hash array by ref with eval
	# so get the keys and fake it
	# get key indices into an array by ref

	local arrayName="$1"

	local -a keys
	declare keyString='${!'$arrayName'[@]}'

	declare -a keys
	eval keys="$keyString"

	# if you want to sort by key
	local -a keysort
	while read key
	do
		keysort+=("$key")
	done < <(
		for key in ${keys[@]}
		do
			echo $key
		done | sort
	)

	keys=${keysort[@]}

	for key in ${keys[@]} 
	do
		eval 'val=${'$arrayName'['$key']}'
		echo "key: $key  val: $val"
	done

	return 0
}


declare -A kv=( ['one']='Illinois' ['two']='Chetco' ['three']='Owyhee' )

showKV kv



