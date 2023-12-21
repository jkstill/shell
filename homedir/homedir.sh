#!/usr/bin/env bash

: << 'COMMENT'

Get the full path to the currently executing script

There is a lengthy stackoverflow thread about this here:
https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself

I am not so concerned about Posix as some may need to be.

So, this works so far

COMMENT

#SCRIPTDIR="$(dirname $(realpath $0))"
#SCRIPTDIR="$(readlink --canonicalize-existing "$0")"
SCRIPTDIR="$(dirname $(readlink -f $0))"

echo SCRIPTDIR: $SCRIPTDIR



