#!/usr/bin/env bash

# Capture the error message from a command and store it in a variable
#

# Capture errors from a backup script while letting the progress bar show on screen
errMsg=$(./err.sh 3>&1 1>&2 2>&3)

if [ -n "$errMsg" ]; then
    echo "Something went wrong! Error: $errMsg"
fi


echo "-----------------------------"
echo

err=$(./err.sh 3>&1 1>&2 2>&3)

echo "err: $err"

