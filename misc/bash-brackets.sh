#!/usr/bin/env bash

: << 'COMMENT'

[[ ]] and [ ] are not quite the same

COMMENT

a=1
b=2

[ "$a" -gt 0 -a "$b" -gt "$a" ] && { echo '[b>a>0]'; }

#[[ $a -gt 0 -a $b -gt $a ]] && { echo '[[b>a>0]]'; }

