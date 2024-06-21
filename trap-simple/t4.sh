#!/usr/bin/env bash

# test trap usage

# use HUP to reload config
function loadConfig {
	typeset SIGTEXT=${1:-'UNKNOWN'}
	typeset SIGNUM=${2:-1}

	echo "trapped $SIGTEXT"
	echo this is the loadConfig function
	echo load/re-load the config file
}

function trapcmds {
	typeset SIGTEXT=${1:-'UNKNOWN'}
	typeset SIGNUM=${2:-1}

	echo "trapped $SIGTEXT"
	echo this is the trapcmds function
	echo do your cleanup here
	echo "Don't forget to exit!"
	exit $SIGNUM
}

function caughtINT {
	trapcmds SIGINT 2
}

function caughtTERM {
	trapcmds SIGTERM 15
}

function caughtHUP {
	loadConfig SIGHUP 1
}


trap "caughtINT" INT
trap "caughtTERM" TERM
trap "caughtHUP" HUP
trap "echo NORMAL EXIT" EXIT
trap

echo PID:$$
echo Press CTL-C or use kill -15 from another session to activate trap
echo Waiting for input...
read x


