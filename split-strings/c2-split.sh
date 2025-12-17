#!/bin/bash
mapfile -t lines < <(ls -1)
for line in "${lines[@]}"; do
    echo "$line"
done

