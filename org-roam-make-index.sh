#!/bin/bash -
#===============================================================================
#
#          FILE: org-roam-make-index.sh
#
#         USAGE: ./org-roam-make-index.sh
#
#   DESCRIPTION: Create an index of your Org Roam links
#
#       OPTIONS: file1: Where to look for links, file2: Where to put those links, headerfile: Optional header file
#        AUTHOR: Javier Scappini
#       CREATED: 04/08/2021 09:37:02 AM
#       LICENSE: MIT
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
IFS=$'\t\n'
SRC=$1
DEST=$2
HEADER=$3

if [[ ! -z "${HEADER}" ]]; then
  cat "${HEADER}" > "${DEST}"
  echo "" >> "${HEADER}" # Adds a separation between headers and files
else
  # Warning here: Will erase the DEST file contents!
  ""> "${DEST}"
fi

FILES=$(grep 'file:' "${SRC}" | sed -e "s/.*://" | sed -e "s/].*//")
for file in $FILES; do
  echo "#+INCLUDE: \"$file\"" >> "${DEST}"
done;
