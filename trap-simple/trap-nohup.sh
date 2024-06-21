#!/bin/bash

cat <<EOF

use trap to run a shell script in the background without nohup

EOF

logFile=mylog.log
sleepTime=60
maxIterations=100

# ignore hangup - similar to nohup (no hangup )
trap -- '' SIGHUP

for i in $(seq 1 $maxIterations)
do
	echo run some command here
	sleep $sleepTime
done >> $logFile  &


