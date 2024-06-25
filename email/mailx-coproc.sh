#!/usr/bin/env bash

coproc EMAIL { mailx -s 'testing' jkstill@gmail.com; }
# use cat if email not desired
#coproc EMAIL { cat; }

ps

echo EMAIL: ${#EMAIL[@]}

date >& ${EMAIL[1]}

echo just another test >& ${EMAIL[1]}

#while read -t 1 output
#do
	#echo output: $output
	#echo test
#done  <& ${EMAIL[0]}


