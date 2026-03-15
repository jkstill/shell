#!/usr/bin/env bash


# simulate a program sending stdout to a file.
echo "$(date '+%Y-%m-%d %H:%M:%S') - this is standard output" > ./err.log
echo "this is standard error" >&2


