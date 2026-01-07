#!/usr/bin/env bash

declare DEBUG=${DEBUG:-'N'}

set -Tauo pipefail

<< COMMENT

This script demonstrates single-stepping through functions using the DEBUG trap.

When you run this script, it will pause before executing each command, displaying the line numbers, function name, and the command about to be executed.

LINENO: Current line number in the script.
BASH_LINENO: Line where the current function was called.

COMMENT

debugMsg () {
	[[ "$DEBUG" == 'Y' ]] && {
		#echo
		echo "DEBUG: $*"
		#echo
	}
}

# use main() unless in a function
[[ $DEBUG == 'Y' ]] && trap 'echo "# $LINENO:$BASH_LINENO ${FUNCNAME[0]}() - $BASH_COMMAND";read' DEBUG

f1 () {
	debugMsg "In f1()"
	debugMsg "Calling date"
	date
}

# single step eval commands
ssEval () {
	local lineno=$1
	local bash_lineno=$2
	shift 2
	echo "# ${FUNCNAME[0]} $lineno:$bash_lineno $(caller) - |$*|"	
	read
	echo -n "${FUNCNAME[0]}: "
	# when the passed command is 1++, it needs to be eval'ed in a subshell to avoid affecting the main shell
	( eval "$*" )
	# the following would affect the main shell
	#eval "$*" 
}


debugMsg "In main?: ${FUNCNAME[0]}"
debugMsg "Calling date, f1"
date
f1

echo "traps: $(trap -p)"
trap DEBUG # clear trap on DEBUG signal
echo "traps after clear: $(trap -p)"

# the following could be dangerous, use with discretion
# show the result of the executed command 
# ++1 will be executed in a subshell for the trap, not affecting the main shell
i=0
[[ $DEBUG == 'Y' ]] && trap 'ssEval $LINENO $BASH_LINENO "$BASH_COMMAND";' DEBUG

date
(( ++i ))
echo "i: $i"

[[ $DEBUG == 'Y' ]] && trap DEBUG


