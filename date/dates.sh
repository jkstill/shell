#!/usr/bin/env bash

# examples of using the linux date command
#

: ${OLD_TZ:='America/Los_Angeles'}

#echo OLD_TZ=$OLD_TZ

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
# Add 1 hour to the date
# Do NOT use th + sign in front of the 1 hour, as then date will interpret is a Time Zone
echo date -d "2017-01-01T12:00:00 1 hour" '+%FT%T %Z'
date -d "2017-01-01T12:00:00 1 hour" '+%FT%T %Z'
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

echo convert ISO date with TZ to epoch time - date -d 'TZ="America/New_York" 2017-01-01T00:00:00' +%s
date -d 'TZ="America/New_York" 2017-01-01T00:00:00' +%s
echo

echo conver the epoch time back to the ISO date with TZ - date -d @1483228800
echo export TZ='America/New_York'
echo date  -d 'TZ="America/New_York" @1483246800' '+%Y-%m-%d %H:%M:%S %Z'
export TZ='America/New_York'
date  -d 'TZ="America/New_York" @1483246800' '+%Y-%m-%d %H:%M:%S %Z'
echo
export TZ=$OLD_TZ

echo convert epoch time to ISO date with TZ - date -d @1483228800 -u
date -d @1483228800 -u
echo

echo convert epoch time to ISO date with TZ and T separator - date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%S%Z"
echo 'using UTC (-u)'
date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%S%Z"
echo

echo e -d @1483228800 -u +"%Y-%m-%dT%H:%M:%SZ" 
date -d @1483228800 -u +"%Y-%m-%dT%H:%M:%S%Z" 
echo


echo add 1 hour and 1 day  to epoch time 
date -d "$(date -d '@1483228800.00234' )" '+%FT%T %Z'
date -d "$(date -d '@1483228800.00234' ) 1 hour" '+%FT%T %Z'
date -d "$(date -d '@1483228800.00234' ) 1 day" '+%FT%T %Z'
echo

echo subtract 76 seconds from an epoch time - date -d "$(date -d '@1483228800' '+%FT%T %Z') -76 seconds" '+%FT%T %Z'
date -d "$(date -d '@1483228800' '+%FT%T %Z')" '+%FT%T %Z'
date -d "$(date -d '@1483228800' '+%FT%T %Z') -76 seconds" '+%FT%T %Z'

