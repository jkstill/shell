#!/usr/bin/env bash

function loop {
    trap 'echo How dare you!' INT
	 i=0
    while true; do
        sleep 5
		  (( i++ ))
		  [[ $i -ge 2 ]] && { exit; }
    done
}

trap 'echo You hit control-C!' INT
loop
