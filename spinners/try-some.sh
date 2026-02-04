#!/usr/bin/env bash

for spinnerName in pong dots earth fish fistBump; do	
	 echo "Spinner: $spinnerName"
	 ./spinner-test.sh "$spinnerName"
done


