#!/bin/bash
IFS=',' read -r -a array < <( tail -n +2 data.csv | head -n 1 )
for element in "${array[@]}"; do
    echo "$element"
done

