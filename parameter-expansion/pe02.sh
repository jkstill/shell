#!/usr/bin/env bash

echo "Before: VAR='$VAR'"
VAR="${VAR:="default_value"}"
echo "After: VAR='$VAR'"
