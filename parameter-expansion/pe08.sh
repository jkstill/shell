#!/usr/bin/env bash

myFile="benoit-01_backup_20240615-153045.tar.gz"

# get the greatest suffix after the first dot
extension="${myFile#*.}"

echo "extension: $extension"

# get the filename without the extension
filename="${myFile%%.*}"
echo "filePart: $filename"

IFS='_' read -r server fileType timeStamp <<< "$filename"

echo "server: $server"
echo "fileType: $fileType"
echo "timeStamp: $timeStamp"

