#!/usr/bin/env bash

set -u

# the regex used should get all lines from the CSV file
# and it works when used to create the grep-tmp.csv file
# but it fails to get all lines when used in process substitution

declare metricName='AVG_READ_TIME'
declare csvFile=test-data.csv
export csvFile

# create a filtered file by normal means
grep -E "(^DISPLAYTIME|,.+,)" $csvFile > grep-tmp.csv
./getcol.sh -d, -c $metricName -f grep-tmp.csv > std-filter.csv

# now create a filtered file with process substitution

#cat <(grep -E "(^DISPLAYTIME|,.+,)" $csvFile) > ps-filter.csv

# getcol.sh reads the file twice.
# when process substitution is used, the results will be incorrect
# the tmp file is a pipe, not a file

./getcol.sh -d, -c $metricName -f <( grep -E "(^DISPLAYTIME|,.+,)" $csvFile) > ps-filter.csv
#cut -f12 -d, <( grep -E "(^DISPLAYTIME|,.+,)" $csvFile | tail -n+2 ) > ps-filter.csv

echo "std-filter.csv: " $(wc -l std-filter.csv)
echo " ps-filter.csv: " $(wc -l ps-filter.csv)

