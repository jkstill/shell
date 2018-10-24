#!/bin/bash

: << 'COMMENT'

tokenize textual output from other commands or from files:

find the most used words in README.md

tokenize.sh < README.md | sort | uniq -c | sort -n | tail -10
  20 be
  20 indexes
  22 are
  24 of
  25 a
  25 in
  32 index
  34 is
  42 to
  60 the

COMMENT


tr -s '[[:space:]]' '\n'

# fmt -1 also works if available
# fmt -1 
