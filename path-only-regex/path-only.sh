#!/usr/bin/env bash


# Regex: Starts with optional /, then letters, numbers, _, -, ., or /
pathLegal () {
	#set -vx
	[[ "$*" =~ ^[a-zA-Z0-9._:~/-]+$ ]] && return 0 || return 1
	#set +vx
}

declare -A test_cases=(
	["/home/user/data/my-file_01.txt"]="legal"

	["/home/user/data/my-file_01_2026-04-08_15:12:42.txt"]="legal"

	['~/user/data/my-file_02.txt']="legal"

	# no spaces!
	["/home/user/data/ my-file_01.txt"]="illegal"

	# no special characters!
	["/home/user/data/my-file_01!.txt"]="illegal"

	# no backslashes!
	["/home\\user\\data\\my-file_01.txt"]="illegal"

	# no ';' or '&'!
	["/home/user/data/my-file_01.txt; rm -rf /"]="illegal"

	# no ';' or '&'!
	["/path-to/trojan &"]="illegal"

	["/home/jkstill/pythian/ai-powered-hc/remote-control/run-connect-tests.sh"]="legal"
)

 
for path in "${!test_cases[@]}"; do

	echo "Testing path: '$path'"
	#continue

	expected="${test_cases[$path]}"

	if pathLegal "$path"; then
		result="legal"
	else
		result="illegal"
	fi

	if [[ "$result" == "$expected" ]]; then
		# result should be RED for FAIL paths and GREEN for success
		# using ANSI escape codes for coloring
		echo -e "   \e[32mPASS: '$path' is $result as expected.\e[0m"
	else
		echo -e "   \e[31mFAIL: '$path' is $result but expected $expected.\e[0m"
	fi
done

