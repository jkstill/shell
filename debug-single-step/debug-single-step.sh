#!/usr/bin/env bash

set -auo pipefail

<< COMMENT

This script demonstrates single-stepping through functions using the DEBUG trap.

When you run this script, it will pause before executing each command, displaying the line numbers, function name, and the command about to be executed.

BASH_LINENO: Line where the current function was called.
LINENO: Current line number in the script.

COMMENT

trap 'echo "# $LINENO:$BASH_LINENO main() - $BASH_COMMAND";read' DEBUG

f1 () {
	trap 'echo "# $LINENO:$BASH_LINENO f1() - $BASH_COMMAND";read' DEBUG
	date
	hostname
}

f2 () {
	trap 'echo "# $LINENO:$BASH_LINENO f2() - $BASH_COMMAND";read' DEBUG
	date
	hostname
}

date
f1
f2
hostname

echo "traps: $(trap -p)"
trap DEBUG # clear trap on DEBUG signal
echo "traps after clear: $(trap -p)"

echo
echo test
echo

# this could be dangerous, use with discretion
# show the result of the executed command 
# ++1 will be executed in a subshell for the trap, not affecting the main shell
i=0
trap 'echo "# $LINENO:$BASH_LINENO main() - $BASH_COMMAND";echo  $(eval "echo eval:; $BASH_COMMAND");' DEBUG

date
(( ++i ))
echo "i: $i"

trap DEBUG

