#!/usr/bin/env bash

set -u

# look in current directory first
spinnerScript='./spinner.sh'

[[ -f "$spinnerScript" ]] || {
	 spinnerScript='~/.local/bin/spinner.sh'
	 [[ -f "$spinnerScript" ]] || {
	  echo "Cannot find spinner.sh script"
	  exit 1
	 }
}

source "$spinnerScript"

spinnerName=${1:-"dots"}

while getopts h arg; do
	case $arg in
		h)
		echo "Usage: $0 [spinner-name]"
		echo "Available spinner names:"
		getSpinnerNames 
		exit 0
		;;
	esac
done


spinner $spinnerName & spinnerPid=$!

cleanup_main() {
  tput cnorm
  printf '\r\033[K\n'   # CR, clear to end of line, newline
  #echo "Cleaning up..."
  kill "$spinnerPid" 2>/dev/null
  wait "$spinnerPid" 2>/dev/null
}
trap cleanup_main INT TERM EXIT

sleep 5


