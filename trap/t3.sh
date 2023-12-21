#!/usr/bin/env bash

function loop {
	i=0
	while true; do
		(( i++ ))
		[[ $i -ge 2 ]] && { exit; } 
		sleep 5
	done
}

trap 'echo You hit control-C!' INT
loop
print 'exiting...'

