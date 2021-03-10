#!/bin/bash

# declare a variable pointing to a file
file='/tmp/test.txt'

# declare a variable that is the name of the variable pointing to a fil
fileVar=file

# declare a new variable that deferences the contents of fileVar, and now has the same value as file
declare newVar=${!fileVar}

echo "  file: $file"
echo "newVar: $newVar"

