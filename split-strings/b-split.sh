#!/bin/bash
input="$( tail -n +2 data.csv | head -n 1 )"
echo "input: $input"

IFS=',' 
for element in $input
do
    echo "$element"
done
unset IFS

