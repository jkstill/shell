#!/bin/bash

. ./asm-chk-functions.sh

. ./email-functions.sh

# unit test header
ut () {
	typeset msg="$*"
	typeset hdrMsg=$(printf "=== Unit Test\n=== $msg" )
	hdr "$hdrMsg"
}

showLogFile () {
	echo 
	echo "Script Log: $scriptLog"
	echo 
}

# setup ASM dirs
typeset -a asmDirsToCheck asmFilesToClear
asmDirsToCheck=(
	+STG_DATA/STG1/DATAFILE
	+STG_DATA/STG1/CONTROLFILE
	+STG_DATA/STG1/TEMPFILE
	+STG_DATA/STG1/ONLINELOG
	+STG_DATA/STG1/ARCHIVELOG/*
)

# check the dire
ut 'Checking asmDirsToCheck array'
for dir in ${asmDirsToCheck[*]}
do
	echo "ASM Directory to check: $dir"
done

# now create the directories to clear
el=0
for dir in ${asmDirsToCheck[*]}
do
	asmFilesToClear[$el]="$dir/*"
	(( el++ ))
done


# check the files
ut 'Checking asmFilesToClear array'
for dir in ${asmFilesToClear[*]}
do
	echo "ASM Directory to clear: $dir"
done


# setup email defaults
toAddress='paget39@pythian.com,t39@pythian.com'
ccAddress='t39lead@pythian.com'

: << 'COMMENT'

These are the parameters the function accepts:

  to="$1"
  cc="$2"
  subject="$3"
  bodyfile="$4"
  attachment="${5:-''}"

If we were testing email, it might look like the following

email_attachment $toAddress $ccAddress 'Something failed in Standby Refresh' /tmp/


This would send email with the log file as the body, and the log file also attached

COMMENT


cat <<-EOF

function getTimeStamp

returns timestamp in YY-MM-DD_HH24:MI:SS (oracle) format

EOF

#dryRunDisable
dryRunEnable

ut 'Testing getTimeStamp'

timeStamp=$(getTimeStamp)
rc=$(chkCmdResults $?)

if [[ $rc -ne 0 ]]; then
	#echo "rc: $rc"
	typeset msg="getTimeStamp failed - We would exit here with error in a real script"
	echo "$msg"
	logger "$msg"
	showLogFile	
	exit 1
else
	typeset msg="getTimeStamp succeeded "
	logger "$msg"
	echo timestamp: $timeStamp
	logger "$timeStamp"
fi
echo

ut 'Testing chkDateFormat - should succeed'

oracleTimeStamp=$(date '+%Y-%m-%d %H:%M:%S')
chkDateFormat "$oracleTimeStamp"
rc=$?

if [[ $rc -eq 0 ]]; then
	typeset msg="chkDateFormat for $oracleTimeStamp succeeded"
	logger "$msg"
	echo "$msg"
	echo 
else
	typeset msg="chkDateFormat for $oracleTimeStamp failed!"
	logger "$msg"
	echo "$msg"
	echo 
	showLogFile	
	exit 1
fi

# not checking ASM unless on a server

dryRunEnable

runCmd "checkAsmDirs ${asmDirsToCheck[*]}"
rc=$?

echo
echo "checkAsmDirs rc: $rc"

if [[ $rc -eq 0 ]]; then
	typeset msg="checkAsmDirs has succeeded"
	echo "$msg"
	logger "$msg"
else
	echo
	typeset msg="Something has gone wrong with checkAsmDirs"
	echo "$msg"
	logger "$msg"
	echo " Please see log $scriptLog"
	echo
	showLogFile	
	exit 1
fi


runCmd "clearAsmDirs ${asmFilesToClear[*]}"
rc=$?

if [[ $rc -eq 0 ]]; then
	typeset msg="clearAsmDirs has succeeded"
	echo 
	echo "$msg"
	echo
	logger "$msg"
else
	echo
	typeset msg="Something has gone wrong with clearAsmDirs"
	echo "$msg"
	logger"$msg"
	echo
	showLogFile	
	exit 1
fi

#dryRunDisable

: << 'COMMENT'

Check the server name is what we expect

COMMENT

ut "validateServer: should succeed"
validateServer 'poirot.jks.com'
rc=$?
if [[ $rc -ne 0 ]]; then
	#echo "rc: $rc"
	typeset msg='validateServer failed detecting server'
	echo "$msg"
	logger "$msg"
	showLogFile	
	exit 1
else
	typeset msg='validateServer succeeded detecting server'
	echo "$msg"
	logger "$msg"
fi
echo


# this test should fail
# running in a subshell for testing purposes
(

	ut "validateServer: should fail"
	validateServer 'poirot.domain.com'

)

rc=$?
if [[ $rc -ne 0 ]]; then
	#echo "rc: $rc"
	typeset msg="We would exit here with error in a real script"
	echo "$msg"
	logger "Server Check: $msg"
	echo
	# this test expected to fail
	# exit 1
else
	typeset msg="validateServer failed to detect incorrect server"
	logger "$msg"
	echo "Server Check: $msg"
	showLogFile	
	exit 1
	echo
fi

ut "Checking dryRun funtions"

dryRunEnable

runCmd "date '+%Y-%m-%d %H:%M:%S'"

dryRunDisable

runCmd "date '+%Y-%m-%d %H:%M:%S'"

ut 'Validiate some files with validateFile'

utFileName=./ut-file-1.ut
touch $utFileName
chmod 400 $utFileName

ut 'Validate File - Read permissions - should succeed'

validateFile $utFileName r
rc=$?

if [[ $rc -eq 0 ]]; then
	typeset msg="validateFile for Read succeeded"
	echo "$msg"
	logger "$msg"
else
	typeset msg="validateFile for Read failed with exit code: $rc"
	echo "$msg"
	logger "$msg"
	exit 1
fi

ut 'Validate File - Execute permissions - should fail'

validateFile $utFileName x
rc=$?

if [[ $rc -eq 4 ]]; then
	typeset msg="validateFile for Execute succeeded - failure code returned"
	echo "$msg"
	logger "$msg"
else
	typeset msg="validateFile for Execute failed with exit code: $rc"
	echo "$msg"
	logger "$msg"
	exit 1
fi


ut 'Validate File - Execute permissions - should succeed'
chmod u+x $utFileName

validateFile $utFileName x
rc=$?

if [[ $rc -eq 0 ]]; then
	typeset msg="validateFile for Execute succeeded"
	echo "$msg"
	logger "$msg"
else
	typeset msg="validateFile for Execute failed with exit code: $rc"
	echo "$msg"
	logger "$msg"
	exit 1
fi

rm -f $utFileName

showLogFile

echo =======================================================
echo == Contents of log


cat $scriptLog

echo =======================================================
echo 


