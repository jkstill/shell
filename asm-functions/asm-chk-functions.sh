#!/bin/bash

#####################################################
# functions and variables that must be at the top
#####################################################

getTimeStamp () {
	echo $(date '+%Y%m%d_%H:%M:%S')
}

scriptLog=/tmp/test-log-$(getTimeStamp).log

logger () {

	typeset msg="$*"

	#timeStamp=$(date '+%Y%m%d_%H:%M:%S')
	timeStamp=$(getTimeStamp)

	echo "$timeStamp-$msg" >> $scriptLog

}

# make sure the command exists
# check for the existence of the command as passed
# if it fails, check if there is one in the PATH, but fail anyway
# only works for pathed commands
# ec.
# chkCmd /usr/local/bin/myscript.sh
# chkCmd ../../local/bin/myscript.sh
chkCmd () {
	typeset cmd=$1
	[[ -x $cmd ]] || {
		logger "command $cmd not found or not executable for you"
		echo "command $cmd not found or not executable for you"

		baseCmd=$(basename $cmd)
		pathCmd=$(which $baseCmd 2>/dev/null)
		if [[ $pathCmd ]]; then
			typeset msg
			pathCmd= $(which $baseCmd)
			msg="The command $baseCmd was found in the path at $pathCmd but will not be used"
			echo "$msg"
			logger "msg"
		fi
		exit 1
	}
}

######################################
# Internal Housekeeping
# Setup and check Commands to use
######################################

ASMCMD=$ORACLE_HOME/bin/asmcmd
chkCmd $ASMCMD

asmDirsToClear=(
	+STG_DATA/STG1/DATAFILE
	+STG_DATA/STG1/CONTROLFILE
	+STG_DATA/STG1/TEMPFILE
	+STG_DATA/STG1/ONLINELOG
	+STG_DATA/STG1/ARCHIVELOG/*
)


####################
# Functional code
####################

# requires exitcode, expected code and command name
chkCmdResults () {
	typeset exitCode=$1
	shift
	typeset expectedCode=$1
	shift
	typeset cmdThatRan="$*"

	typeset resultsMsg

	if [[ $exitCode -eq $expectedCode ]]; then
		resultsMsg="CMD: $cmdThatRan Succeeded with exit code $exitCode"
	else
		resultsMsg="CMD: $cmdThatRan failed with exit code $exitCode"
	fi

	logger "$resultsMsg";

	echo $exitCode
}


###################################
# chkAsmDirs
# are the directories there?
# are the files all gone?
# pass an array of directory names
###################################
checkAsmDirs () {
	typeset -a dirs=("$@")

	for dir in ${dirs[*]} 
	do
		# do not use echo in prod code
		#echo "Checking ASM Dir: $dir"
		logger "Checking ASM Dir Existence: $dir"

		# directory exists?
		CMD="$ASMCMD ls $dir"
		logger "checkAsmDirs dir exist CMD: $CMD"

		typeset resultTxt rv results
		resultTxt=$($CMD 2>&1)
		rv=$?
		#echo "RV: $rv" >&2
		results=$(chkCmdResults $rv 0 $CMD)

		#################################################################
		# There is a problem with with false positives with asmcmd
		# if no connection can be made, ASM will throw up a lot of error 
		# messages, and then exit with 0
		# I would call this a bug
		#################################################################

		if [[ $results -ne 0 ]]; then
			# decide to return or exit
			typeset msg="checkAsmDirs: Failed to find Directory $dir in checkAsmDirs - exit code $results"
			logger "$msg"
			logger "checkAsmDirs: results - $resultTxt"
			echo 1
			return
		fi

		logger "Checking for ASM Files in: $dir"

		# no files in directory ?
		# asmcmd returns 255 if there are no files found, which is what we want
		CMD="$ASMCMD ls $dir/*"
		logger "checkAsmDirs dir files CMD: $CMD"

		resultTxt=$($CMD 2>&1)
		rv=$?
		results=$(chkCmdResults $rv 255 $CMD)

		if [[ $results -ne 255 ]]; then
			# decide to return or exit
			typeset msg="checkAsmDirs: Failed to find Directory $dir in checkAsmDirs - exit code $results"
			logger "checkAsmDirs: $msg"
			logger "checkAsmDirs: results - $resultTxt"
			echo 1
			return
		fi

	done

	echo 0
}

########################################
# clearAsmDirs
#
# expects an array of ASM Directories
########################################
clearAsmDirs () {
	typeset -a dirs=("$@")

	for dir in ${dirs[*]} 
	do
		# do not use echo in prod code
		#echo "Checking ASM Dir: $dir"
		logger "Clear ASM Dir Existence: $dir"

		# clear directory of files
		# replace with rm, cuz I do not want to test this here
		CMD="$ASMCMD ls $dir/*"
		logger "clearAsmDirs CMD: $CMD"

		typeset resultTxt results rv
		resultTxt=$($CMD 2>&1)
		rv=$?
		results=$(chkCmdResults $? 0 $CMD)

		#################################################################
		# There is a problem with with false positives with asmcmd
		# if no connection can be made, ASM will throw up a lot of error 
		# messages, and then exit with 0
		# I would call this a bug
		#################################################################

		if [[ $results -ne 0 ]]; then
			# decide to return or exit
			typeset msg="Failed to clear Directory $dir in clearAsmDirs - exit code $results"
			echo 1
			return
		fi

	done

	echo 0
}

chkResults=$(checkAsmDirs ${asmDirsToClear[*]})

echo chkResults: $chkResults

if [[ chkResults -eq 0 ]]; then
	echo "checkAsmDirs has succeeded"
else
	echo
	echo "Something has gone wrong with checkAsmDirs"
	echo "Please see log $scriptLog"
	echo
	exit $chkResults
fi


chkResults=$(clearAsmDirs ${asmDirsToClear[*]})

echo chkResults: $chkResults

if [[ chkResults ]]; then
	echo "clearAsmDirs has succeeded"
else
	echo
	echo "Something has gone wrong with clearAsmDirs"
	echo "Please see log $scriptLog"
	echo
	exit $chkResults
fi

echo scriptLog: $scriptLog


cat $scriptLog
echo ==========================


