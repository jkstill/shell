#!/usr/bin/env bash

trap 'echo "# $LINENO:$BASH_LINENO main() - $BASH_COMMAND";read' DEBUG

f1 () {
	trap 'echo "# $LINENO:$BASH_LINENO f1() - $BASH_COMMAND";read' DEBUG
	date
	hostname
}

date '+%Y-%m-%d %H:%M:%S'
f1

trap DEBUG # clear trap on DEBUG signal

