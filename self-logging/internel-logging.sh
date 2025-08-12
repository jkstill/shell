#!/usr/bin/env bash

: << 'LOGGING'

Here is one method of always logging everything from a script

No need to do it one the command line

LOGGING


logDir='logs';

mkdir -p $logDir

logFile=$logDir/self-logging-$(date +%Y-%m-%d_%H-%M-%S).log

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
# process substitution
# clear/recreate the logfile
> $logFile
exec 1> >(tee -ia $logFile)
exec 2> >(tee -ia $logFile >&2)

# now all STDOUT/STDERR will be logged.

# it would be unwise to call this script recursively.

# if you would like to see the commands
# set -v

# reset the channels
exec 1>&1
exec 2>&1

ls -l /

date

echo
echo logFile: $logFile
echo


