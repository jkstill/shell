#!/usr/bin/env bash

echo '$*: ' "$*"
echo '$*: ' $*
echo 'for loop quoted: '
for i in "$*"; do
	 echo $i
done

echo 'for loop unquoted: '
for i in $*; do
	 echo $i
done

echo '$@: ' "$@"
echo '$@: ' $@
echo 'for loop: quoted '
for i in "$@"; do
	 echo $i
done

echo 'for loop: unquoted '
for i in $@; do
	 echo $i
done

declare -a arr=("$@")
echo 'for loop: array '
for i in "${arr[@]}"; do
	 echo $i
done

