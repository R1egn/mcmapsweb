#!/bin/bash

# As this process is bulky try to tidy up.
# This process should not break anything.

# Compress stuff that isn't used much
# go through and remove duplicate files (keeping oldest and current) and update links where possible.
echo Hard linking duplicate files.
declare -A arr
shopt -s globstar

for file in /home/share/mcmap/**; do
  [[ -f "$file" ]] || continue
   
  read cksm _ < <(md5sum "$file")
  if [ -z ${arr[$cksm]} ]; then 
    arr[$cksm]=$file
  else
    ln ${arr[$cksm]} $file -fv # This creates links for duplicate files.
  fi
done


# Perhaps optimize some large maps 

