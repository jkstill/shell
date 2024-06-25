#!/usr/bin/env bash

#set -u

declare ceilingSeconds=25

declare totalSeconds=0

declare intervalSeconds=7

declare failsafeCounter=0
declare failsafeCeiling=200

while :
do


	# the '$' sigil is not required when doing arithmetic in (( ))
	# thought is does not seem to break anything if present
	(( totalSeconds += $intervalSeconds ))

	cat <<-EOF
     =================================
     ceilingSeconds: $ceilingSeconds
     intervalSeconds: $intervalSeconds
     totalSeconds: $totalSeconds
  	
	EOF

	[[ $totalSeconds -ge $ceilingSeconds ]] && { echo "finished"; exit 0; }

	(( failsafeCounter++ ))
	[[ $failsafeCounter -gt $failsafeCeiling ]] && { echo "failsafe encountered"; exit 1; }

done
