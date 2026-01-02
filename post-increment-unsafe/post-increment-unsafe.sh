#!/usr/bin/env bash

declare i=${1:-0}
echo
echo "i: $i"

set -e
set -v

# set -e will cause an exit because '(( i++ ))' returns with a non-zero exit code when incrementing from 0 to 1


# these will exit with error
(( i++ )); echo $? $i
(( i++ )); echo $? $i
(( i++ )); echo $? $i


# these will work
(( ++i )); echo $? $i
i=$(( i+1 )); echo $? $i
(( i+=1 )); echo $? $i
(( i+=1 )); echo $? $i
(( i+=1 )); echo $? $i
