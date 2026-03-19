#!/usr/bin/env bash

# test if a key exists in a hash array
#
declare -A myhash=()
myhash["key1"]="value1"
myhash["key2"]="value2"

for key in key1 key2 key3; do
	 if [[ -v myhash["$key"] ]]; then
		  echo "$key exists in myhash"
	 else
		  echo "$key does not exist in myhash"
	 fi
done


