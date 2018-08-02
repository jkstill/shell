#!/bin/sh

function loop {
    while true; do
        sleep 5
    done
}

trap 'echo You hit control-C!' INT
loop
print 'exiting...'

