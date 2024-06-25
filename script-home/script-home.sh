#!/usr/bin/env bash


# always returns the location of the current script
scriptHome=$(dirname -- "$( readlink -f -- "$0"; )")

echo home: $scriptHome


