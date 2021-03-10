#!/usr/bin/env bash

# exit if any variables uninitialized
set -u

source ansi-color.sh

colorPrint bg=red fg=white msg='This is an error message!'

colorPrint bg=lightGreen fg=black msg='Success!'

# invalid colors
colorPrint bg=orange fg=black msg='Success!'

colorPrint bg=green fg=blackish msg='Success!'


