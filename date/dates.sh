#!/usr/bin/env bash

# examples of using the linux date command
#

#
banner () {
	 echo
	 echo "====================================================================="
	 echo "== $*"
	 echo "====================================================================="
	 echo
}

banner current date
echo date
date

echo date +"%Y-%m-%d %H:%M:%S"
date +"%Y-%m-%d %H:%M:%S"
echo

echo date +"%Y-%m-%d %H:%M:%S %Z"
date +"%Y-%m-%d %H:%M:%S %Z"
echo

echo date +"%Y-%m-%d %H:%M:%S %Z %z"
date +"%Y-%m-%d %H:%M:%S %Z %z"
echo

echo date +"%Y-%m-%d %H:%M:%S %Z %z %A"
date +"%Y-%m-%d %H:%M:%S %Z %z %A"
echo

echo date +"%Y-%m-%d %H:%M:%S %Z %z %A %B"
date +"%Y-%m-%d %H:%M:%S %Z %z %A %B"
echo

banner add time to arbitrary date

echo date -d "2017-01-01 12:00:00" '+%FT%T %Z'
date -d "2017-01-01 12:00:00" '+%FT%T %Z'
echo
# this works correctly if the formet is set to %FT%T %Z
# the following commented out line does not work
#date -d "2017-01-01T12:00:00 +1 hour" '+%FT%T %Z'
echo date -d "$(date -d '2017-01-01T12:00:00' '+%FT%T %Z') +1 hour" '+%FT%T %Z'
date -d "$(date -d '2017-01-01T12:00:00' '+%FT%T %Z') +1 hour" '+%FT%T %Z'
echo


banner epoch time

echo current epoch time - date +%s
date +%s
echo

echo convert date to epoch time - date -d "2017-01-01" +%s
date -d "2017-01-01" +%s
echo

echo convert epoch time to date - date -d @1483228800
date -d @1483228800
echo

echo convert ISO date with TZ to epoch time - date -d "2017-01-01T00:00:00Z" +%s
date -d "2017-01-01T00:00:00Z" +%s
echo

echo date  -d '2025-03-14 13:36:06.953105+08:00' '+%s'
date  -d '2025-03-14 13:36:06.953105+08:00' '+%s'
echo

echo convert epoch time to ISO date with TZ - date -d @1483228800 -u
date -d @1483228800 -u
echo

echo convert epoch time to ISO date with TZ and T separator - date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ"
date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ"
echo

echo add seconds to epoch time - date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ" -d "+1 day"
echo source date is shown first
date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ" 
echo

# it would be nice if this worked: date -d '@1483228800 + 1 day' -u +"%Y-%m-%dT%H:%M:%SZ" 
# but it does not
# this does work:  date -d "$(date -d '@000.00234' '+%FT%T.%N %Z') + 1 hour"
# the epoch must be converted to a date string first

echo add 1 hour to epoch time - date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ" -d "+1 hour"
date -d "$(date -d '@1483228800.00234' '+%FT%T.%N %Z')" '+%FT%T %Z'
date -d "$(date -d '@1483228800.00234' '+%FT%T.%N %Z') +1 hour" '+%FT%T %Z'
echo

echo subtrace 76 seconds from an epoch time - date -d "$(date -d '@1483228800' '+%FT%T %Z') -76 seconds" '+%FT%T %Z'
date -d "$(date -d '@1483228800' '+%FT%T %Z') -76 seconds" '+%FT%T %Z'





