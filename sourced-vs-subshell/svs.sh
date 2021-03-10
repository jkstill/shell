#!/bin/bash

echo BASH_SOURCE: "$BASH_SOURCE"

[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0

[[ $sourced -eq 0 ]] && accessed='SUBSHELL' || accessed='SOURCED'

echo sourced: $sourced
echo accessed: $accessed


