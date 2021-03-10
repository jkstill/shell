#!/bin/bash

declare -Ag cmds

cmds[grep]=''
cmds[awk]=''
cmds[sort]=''
#cmds[junk]=''
cmds[tee]=''

assert_loc () {

	typeset cmd=$1
	typeset location=$2

	[[ -z $location ]] && {
		echo 
		echo assert_loc: Cannot locate $cmd in accepted paths
		echo 
		exit 99
	}
}

hardpath () {

	for cmd in ${!cmds[@]}
	do
		# echo CMD: $cmd
		# look for the command in /bin /usr/bin and /usr/local/bin
	 
		typeset location=''

		if [ -x /bin/${cmd} ]; then
			location=/bin/${cmd}
		elif [ -x /usr/bin/${cmd} ]; then
			location=/usr/bin/${cmd}
		elif [ -x /usr/local/bin/${cmd} ]; then
			location=/usr/local/bin/${cmd}
		fi

		assert_loc $cmd $location

		cmds[$cmd]=$location

	done
}


hardpath

echo awk: ${cmds[awk]} 
echo tee: ${cmds[tee]} 
echo grep: ${cmds[grep]} 
echo sort: ${cmds[sort]} 

# ${cmds[grep]} jkstill /etc/passwd

