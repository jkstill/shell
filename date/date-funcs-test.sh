#!/usr/bin/env bash

# cd to the directory of the script
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

source ./date-funcs.sh

echo Get the default Date
testDate="$(date)"
echo "   Default Date: $testDate"

echo Convert to ISO Date
isoDate="$(to_iso_date $testDate)"
echo "   ISO Date: $isoDate"

echo Convert to RFC Date
rfcDate="$(to_rfc_date $testDate)"
echo "   RFC Date: $rfcDate"

echo Convert to Epoch Timestamp
epochTimestamp="$(to_epoch_timestamp $testDate)"
echo "   Epoch Timestamp: $epochTimestamp"

echo Convert back from Epoch to ISO Date
isoFromEpoch="$(from_epoch_to_iso $epochTimestamp)"
echo "   ISO Date from Epoch: $isoFromEpoch"

echo Convert back from Epoch to RFC Date
rfcFromEpoch="$(from_epoch_to_rfc $epochTimestamp)"
echo "   RFC Date from Epoch: $rfcFromEpoch"


