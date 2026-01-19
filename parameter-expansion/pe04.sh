#!/usr/bin/env bash


A_OK=0
A_OK="${A:+1}"

B_OK=0
B_OK="${B:+1}"

echo "A_OK = $A_OK"
echo "B_OK = $B_OK"


# test if both A and B are set
if [[ $A_OK -eq 1 && $B_OK -eq 1 ]]; then
	 echo "Both A and B are set."
	 exit 0
fi
#
# test if only A is set
if [[ $A_OK -eq 1 && $B_OK -eq 0 ]]; then
	 echo "Only A is set."
	 exit 1
fi
# test if only B is set
if [[ $A_OK -eq 0 && $B_OK -eq 1 ]]; then
	 echo "Only B is set."
	 exit 2
fi

# test if neither A nor B is set
if [[ $A_OK -eq 0 && $B_OK -eq 0 ]]; then
	 echo "Neither A nor B is set."
	 exit 3
fi

