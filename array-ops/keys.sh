#!/usr/bin/env bash

declare -A myhash

myhash["key1"]="value1"
myhash["key2"]="value2"
myhash["key3"]="value3"

# reference the value of the first availble key, based on the keys available in the hash

allKeys=${!myhash[@]}

echo "allKeys: $allKeys"

# this is the first available key, based on the keys available in the hash
# not necessarily the first key that was added to the hash, as hashes are not ordered
firstKey=${allKeys%% *}
echo "firstKey: |$firstKey|"



