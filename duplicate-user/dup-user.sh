#!/usr/bin/env bash

SRC=$1
DEST=$2

SRC_GROUPS=$(id -Gn ${SRC} | sed "s/ /,/g" | sed -r 's/\<'${SRC}'\>\b,?//g')
SRC_SHELL=$(awk -F : -v name=${SRC} '(name == $1) { print $7 }' /etc/passwd)

echo "useradd --groups ${SRC_GROUPS} --shell ${SRC_SHELL} --create-home ${DEST}"
echo "passwd ${DEST}"

