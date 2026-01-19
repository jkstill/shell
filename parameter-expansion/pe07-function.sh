#!/usr/bin/env bash

# desconstruct a backup filename into its components

echo
echo Assume a server name of benoit-01.example.com
echo
echo The file name is created with this template: 
echo '$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz'
echo
echo "filename example: backups/db/benoit-01_backup_20240615-153045.tar.gz"
myFile="backups/db/benoit-01_backup_20240615-153045.tar.gz"

string2Array () {

	local myString="$1"; shift
	local delimiter="$1"; shift
	# local -n requires bash 4.3+
	local -n arrayName="$1"; shift   # pass array by reference

	IFS="$delimiter" read -r -a arrayName <<< "$myString"

}

joinArray () {
	local delimiter="$1"; shift
	local -n destString="$1"; shift
	local -n arrayName="$1"; shift   # pass array by reference
	# join array elements into a string
	# if '@' was used instead of '*', each element would be quoted separately
	IFS="$delimiter" destString="${arrayName[*]}"
}


time for i in {1..100000} ; do

# get just the filename without path
string2Array "$myFile" "/" pathArray
myFile="${pathArray[-1]}"

# remove the suffix
string2Array "$myFile" "." fileArray
noSuffix="${fileArray[0]}"

# remove the file part from the array
# join the rest back together with dots
unset fileArray[0]
joinArray '.' suffix fileArray

# get the server name, file type and timestamp
string2Array "$noSuffix" "_" nameArray

serverName="${nameArray[0]}"
fileType="${nameArray[1]}"
backupTimestamp="${nameArray[2]}"

done

cat <<-EOF

         Filename: $myFile
      Server name: $serverName
        File type: $fileType
 Backup timestamp: $backupTimestamp
        Extension: $suffix

EOF

