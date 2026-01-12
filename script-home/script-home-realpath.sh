#!/usr/bin/env bash


# always returns the location of the current script
scriptHome=$(dirname -- "$( realpath -s -- "$0"; )")

echo home: $scriptHome

cd $scriptHome || { echo "cd $scriptHome failed"; exit 1; }



