#!/usr/bin/env bash

echo "this is p1/p2/p3/script-home-realpath-test.sh"

#!/usr/bin/env bash


# always returns the location of the current script
scriptHome=$(dirname -- "$( realpath -s -- "$0"; )")

echo home: $scriptHome

cd $scriptHome || { echo "cd $scriptHome failed"; exit 1; }


