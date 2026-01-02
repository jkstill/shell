#!/usr/bin/env bash

trap 'echo "# main() - $BASH_COMMAND";read' DEBUG

f1 () {
	trap 'echo "# f1() - $BASH_COMMAND";read' DEBUG
	date
}

f2 () {
	trap 'echo "# f2() - $BASH_COMMAND";read' DEBUG
	date
}


date
f1
f2
hostname
