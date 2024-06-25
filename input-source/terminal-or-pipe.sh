#!/bin/bash

: << 'COMMENT'

$  ./terminal-or-pipe.sh
STDIN is from a terminal

$  echo test | ./terminal-or-pipe.sh
STDIN is from a pipe


COMMENT

if [[ -t 0 ]]; then
	echo STDIN is from a terminal
else
	echo STDIN is from a pipe
fi
