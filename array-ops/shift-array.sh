#!/usr/bin/env bash

# shift an array

declare -a ary=(one two three)

echo ${ary[0]}
ary=("${ary[@]:1}")

echo ${ary[0]}
ary=("${ary[@]:1}")

echo ${ary[0]}
ary=("${ary[@]:1}")

echo ${ary[0]}
