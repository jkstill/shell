#!/bin/bash

[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0

[[ $sourced -eq 0 ]] && accessed='SUBSHELL' || accessed='SOURCED'

echo $sourced
echo $accessed


