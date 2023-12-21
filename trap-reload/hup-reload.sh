#!/usr/bin/env bash

: << 'SET'

 -a export all vars/functions
 -e pipeline fail
 -u exit on undeclared variable
    useful at times to set post init steps

SET

set -aeu

declare scriptPath=$(dirname $0)
cd $scriptPath || { echo "cannot cd '$scriptPath'"; exit 1; }

declare scriptHome=$(pwd)



configScript=$scriptHome/vars.conf

reload () {

	source  $configScript

}

scriptExit () {
	echo 
	echo "Bye!"
	echo 
	exit 0
}

source  $configScript

trap 'reload' HUP
trap 'scriptExit' INT TERM

declare iteration=0

while :
do
	echo '==================='
	echo Loop $iteration
	echo "sleep time: $SLEEP_TIME"
	echo "cmd: $CMD"

	sleep $SLEEP_TIME

	#(( iteration++ )) # for some reason this terminates the loop
	(( iteration = iteration + 1 ))

done


