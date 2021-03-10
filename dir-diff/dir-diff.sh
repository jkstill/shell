#!/usr/bin/env bash

: << 'PURPOSE'

This script is used to compare a directory of files to another directory.

Only files in the specified directory are checked - there is no descent into other directories

- If the files is found in both directories

Do a diff

- If the file is in the local directory only

Print a message

- If the file is in the remote directory only

Print a message


PURPOSE


dirChk () {
	local dir2chk="$1"

	[[ -r "$dir2chk" ]] || {
		echo
		echo "directory '$dir2chk' does not exist, or cannot be read"
		echo 
		return 1
	}

	[[ -x "$dir2chk" ]] || {
		echo
		echo "directory '$dir2chk' cannot be traversed"
		echo 
		return 2
	}

	[[ -d "$dir2chk" ]] || {
		echo
		echo "'$dir2chk' is not a directory"
		echo
		return 3
	}

	return 0

}

ok () {
	local rc="$1"; shift
	local msg="$@"

	[[ $rc -eq 0 ]] || {
		echo
		echo "rc: $rc"
		echo "$msg"
		echo
		exit 1
	}

}

# pass the name of the array, not the array
getFiles () {
	local arrayName="$1";shift
	local dir2chk="$1"
	
	dirChk "$dir2chk"
	ok $? "getFiles: Directory '$dir2chk' seems to be invalid"

	declare -a files

	local i=0
	for file in $(find "$dir2chk" -maxdepth 1 -type f)
	do
		eval "$arrayName[$i]"="$file"
		(( i++ ))
	done

	return 0
}

# pass the name of the array, not the array
displayFiles () {
	local arrayName="$1"[@];shift
	local msg="$@"

	declare -a files
	# expand the passed array name values
	files=("${!arrayName}")

	echo
	echo "files: $msg"
	for file in "${files[@]}"
	do
		echo "$file"
	done
}

: ${1:?Please include the full path to the local directory}

declare localDir="$1"
dirChk "$localDir"
ok $? "Local Directory $localDir seems to be invalid"

: ${2:?Please include the full path to the remote directory}
declare remoteDir="$2"
dirChk "$remoteDir"
ok $? "Remote Directory $remoteDir seems to be invalid"

cat <<-EOF

Continuing with comparison:

  local  dir: $localDir
  remote dir: $remoteDir

EOF

declare -a localFiles
declare -a remoteFiles

getFiles localFiles "$localDir" 
ok $? "There was a problem getting files from directory '$localDir'"
#displayFiles "localFiles" "Local Files"

getFiles remoteFiles "$remoteDir" 
ok $? "There was a problem getting files from directory '$remoteDir'"
#displayFiles "remoteFiles" "Remote Files"


declare -A diffFiles

# add local files to the array

for file in "${localFiles[@]}"
do
	diffFiles[$file]=''
	localBaseFile=$(basename $file)
	#echo "base: $localBaseFile"

	# now look for a match in remot files
	for rfileKey in "${!remoteFiles[@]}"
	do
		declare rfile=${remoteFiles[$rfileKey]}
		#echo "rfile: $rfile"
		remoteBaseFile=$(basename $rfile)
		if [[ "$localBaseFile" == "$remoteBaseFile" ]]; then
			#echo "Removing rfile"
			diffFiles["$file"]="$rfile"
			# those are left in remoteFiles have no match, and will be reported later
			unset remoteFiles["$rfileKey"]
		fi
	done
done

displayFiles "remoteFiles" "Remote Files that you may want to copy to the Local directory"

# now remove entries in localFiles that have a match in diffFiles

for lfileKey in "${!localFiles[@]}"
do
	declare lfile="${localFiles[$lfileKey]}"
	[[ "${diffFiles[$lfile]}" ]] && { unset localFiles["$lfileKey]"]; }
done

displayFiles "localFiles" "Remaining Local Files"

# need a displayFiles for Associative Arrays
echo 
echo "Performing diff into directory ./diffs"
mkdir -p diffs

echo 
for key in ${!diffFiles[@]}
do
	#echo key: $key
	#echo "  file: ${diffFiles[$key]}"
	#echo "  diff: ${diffFiles[$key]}"

	outFile=$(basename $key)

	echo diff: "$key" 
	diff "$key" "${diffFiles[$key]}" > diffs/$outFile.diff

done


