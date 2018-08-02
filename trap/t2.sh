#!/bin/sh

function loop {
    trap 'echo How dare you!' INT
    while true; do
        sleep 5
    done
}

trap 'echo You hit control-C!' INT
loop
