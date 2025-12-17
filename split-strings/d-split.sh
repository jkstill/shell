#!/bin/bash

input="apple,banana,cherry,date"
array=(${input//,/ })

for element in ${array[@]}; do
    echo "$element"
done


