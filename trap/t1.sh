#!/usr/bin/env bash

function settrap {
	trap 'echo You hit control-C!' INT
}

settrap

i=0
while true; do
	sleep 5
	(( i++ ))
	if [[ $i -ge 2 ]]; then
		exit
	fi
done


