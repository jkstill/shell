#!/usr/bin/env	 bash

# the order of options does not really matter
# all these will work the same say
# set -e -o pipefail
# set -o pipefail -e
# The next line does work, even though 'e' appears to be attached to 'o'
# set -oe pipefail
#

# the 

# use the -e option to exit immediately if a command exits with a non-zero status

#set -oe  pipefail
set -o pipefail

echo "test 'true | true'"
true | true
echo "rc: $?"

echo "test 'true | false'"
true | false
echo "rc: $?"

echo 
echo "without pipefail, this commmand will return 0 even though one command failed"
echo "test 'false | true'"
false | true
echo "rc: $?"



