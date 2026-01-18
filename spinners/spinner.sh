#!/usr/bin/env bash

# A simple spinner function for bash scripts
# 
# Spinner files from: https://github.com/sindresorhus/cli-spinners
# The following license applies to the spinner JSON data:
# License: MIT
# Copyright (c) Sindre Sorhus <
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
# (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#

getSpinnerFile() {

	spinnerDataHome=$1; shift
	spinnerFileSource=$1; shift
	spinnerFile=$1; shift

	[[ -f "${spinnerFile}" ]] || {

		local -A getFileCMDS=()

		CURL=$(type -pf curl) && {
			getFileCMDS["curl"]="${CURL} -fsSL -o "
		}

		WGET=$(type -pf wget) && {
			getFileCMDS["wget"]="${WGET} -q -O "
		}

		[[ ${#getFileCMDS[@]} -eq 0 ]] && {
			echo "No download command (curl or wget) found to get spinner file" >&2
			return 1
		}


		mkdir -p "${spinnerDataHome}" || { echo "mkdir -p ${spinnerDataHome} failed" >&2; return 1; }
		for cmd in "${!getFileCMDS[@]}"; do
			${getFileCMDS[${cmd}]} "${spinnerFile}" "${spinnerFileSource}" 
			if [[ $? -eq 0 ]]; then
				#echo "Downloaded ${spinnerFile} using ${cmd}"
				break
			else
				echo "Failed to download ${spinnerFile} using ${cmd}" >&2
				continue
			fi
			echo "Could not download ${spinnerFile} using any available command" >&2
			return 1
		done
	}

	return 0

}

getSpinnerNames() {

	spinnerDataHome="${XDG_DATA_HOME:-$HOME/.local/share}/spinners"
	spinnerFileSource='https://raw.githubusercontent.com/jkstill/cli-spinners/refs/heads/main/spinners.json'
	spinnerFile="${spinnerDataHome}/spinners.json"

	#set  -x
	getSpinnerFile "${spinnerDataHome=}" "${spinnerFileSource}" "${spinnerFile}" || {
		echo "Could not get spinner file" >&2
		return 1
	}

	JQ=$(type -pf jq) || {
		echo "jq is required to parse spinner file" >&2
		return 1
	}

	local spinnerNames=()
	readarray spinnerNames < <($JQ -r 'keys[]' $spinnerFile 2>/dev/null ) 2>/dev/null || {
		echo "Could not parse spinner names" >&2
		return 1
	}

	# there are newlines in data, just print as is
	printf "%s" "${spinnerNames[@]}"

	return 0

}

spinner() {

	local delay=0.1
	local spinstr='|/-\'

	dataHome=${XDG_DATA_HOME:-$HOME/.local/share}
	scriptDataHome="${dataHome}/spinners"

	spinnerFileSource='https://raw.githubusercontent.com/jkstill/cli-spinners/refs/heads/main/spinners.json'
	spinnerFile="${scriptDataHome}/spinners.json"

	#set  -x
	getSpinnerFile "${scriptDataHome}" "${spinnerFileSource}" "${spinnerFile}" || {
		echo "Could not get spinner file" >&2
		return 1
	}

	#echo "Spinner file: ${spinnerFile}"

	JQ=$(type -pf jq) || {
		echo "jq is required to parse spinner file" >&2
		return 1
	}

	local spinnerData=()
	#echo "spinnerFile: ${spinnerFile}" >&2

	readarray spinnerData < <($JQ -r --arg k $spinnerName '.[$k].frames[]' $spinnerFile 2>/dev/null ) 2>/dev/null || {
		echo "Could not parse spinner data for spinner: $spinnerName" >&2
		return 1
	}

	#printf "spinnerData: %s\n" "${spinnerData[@]}" >&2

	[[ ${#spinnerData[@]} -eq 0 ]] && {
		echo "No spinner data found for spinner: $spinnerName" >&2
		return 1
	}

	# remove quotes from each frame
	for i in "${!spinnerData[@]}"; do
		spinnerData[$i]=${spinnerData[$i]//\"/}
		spinnerData[$i]=${spinnerData[$i]//$'\n'/}
	done

	local returnNow=0

	cleanup() {
		tput cnorm
		printf '\r\033[K'  # return to col 0 and clear line
	}

	trap 'cleanup; exit 0' INT TERM QUIT HUP
	trap 'cleanup' EXIT

	tput civis  # hide cursor
	for (( i=1; ; i++ )); do
		local IFS=''
		local frame=${spinnerData[i % ${#spinnerData[@]}]}
		printf "\r%s" "${frame}"
		sleep $delay
		[[ ${returnNow} -eq 1 ]] && break
	done

}


