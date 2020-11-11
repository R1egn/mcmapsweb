#!/bin/bash

# Compress stuff that isn't used much.  So far this script links files that 
# have the exact same content. It should not break anything.

# TODO As this process rechecks everything try to tidy it up.

# Link duplicate files (keeping oldest and current) and update links where 
# possible.
echo Hard linking duplicate files.
declare -A arr
shopt -s globstar

# TODO Optimize files already double linked.
for file in /home/share/mcmap/image/**; do
  # -f True if file exists and is a regular file.
  [[ -f "$file" ]] || continue
   
  read cksm _ < <(md5sum "$file")
  if [ -z ${arr[$cksm]} ]; then 
    arr[$cksm]=$file
  else
    # This creates links for duplicate files.
    ln ${arr[$cksm]} $file -fv
  fi
done


# TODO Perhaps optimize some large maps with an image tool.

