#!/usr/bin/env bash

# desconstruct a backup filename into its components

echo
echo Assume a server name of benoit-01.example.com
echo
echo The file name is created with this template: 
echo '$(hostname -s)_backup_$(date +%Y%m%d-%H%M%S).tar.gz'
echo
echo "filename example: benoit-01_backup_20240615-153045.tar.gz"
myFile="benoit-01_backup_20240615-153045.tar.gz"

noSuffix1="${myFile%.*}"
# Remove largest suffix pattern
noSuffix2="${myFile%%.*}"

# get the suffix and remove the dot
suffix1="${myFile#${noSuffix1}}" && suffix1="${suffix1:1}"
suffix2="${myFile#${noSuffix2}}" && suffix2="${suffix2:1}"

suffix=''; noSuffix=''

[[ $noSuffix1 == $noSuffix2 ]] && {
	suffix="$suffix1"
	noSuffix="$noSuffix1"
} || {
	# for instance with .tgz and .tar.gz
	suffix="$suffix2"
	noSuffix="$noSuffix2"
}

# extract the server name
serverName="${noSuffix%%_*}"

# extract the type of file, ie. 'backup'
# remove the server name and the underscore
restOfFile="${noSuffix#${serverName}_}"
# remove from remaining string everything after the first underscore 
fileType="${restOfFile%%_*}"

# extract the backup timestamp
# remove everything up to the last underscore
backupTimestamp="${noSuffix##*_}"

cat <<-EOF

         Filename: $myFile
      Server name: $serverName
        File type: $fileType
 Backup timestamp: $backupTimestamp
        Extension: $suffix

EOF

