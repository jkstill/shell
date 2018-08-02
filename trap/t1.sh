#!/bin/sh

function settrap {
	trap 'echo You hit control-C!' INT
}

settrap
while true; do
	sleep 5
done


