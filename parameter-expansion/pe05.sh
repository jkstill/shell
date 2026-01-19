#!/usr/bin/env bash
myString="Hello, World!"
# count from the 7th position, get 5 characters
subString1="${myString:7:5}"
# count backwards from the end, get 5 characters
subString2="${myString: -6:5}"
echo "  myString: $myString"
echo "subString1: $subString1"
echo "subString2: $subString2"
