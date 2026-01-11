#!/usr/bin/env bash

for spinnerName in $( jq -r 'keys[]' spinners.json ); do
	 echo "Spinner: $spinnerName"
	 ./spinner-test.sh "$spinnerName"
done


