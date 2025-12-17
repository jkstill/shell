#!/bin/bash
input="$( tail -n +2 data.csv | head -n 1 )"
IFS=',' 
mapfile -t array < <(tail -n +2 data.csv | head -n 1 | tr ',' '\n')
for element in "${array[@]}"; do
    echo "$element"
done

