#!/bin/bash

# Preset defaults for rendering maps from centre.
#
# Usage ~/map.sh size. It always centered on world origin.

if [ -z $1 ]; then size=2000; else size=$1; fi		# default to 2000 
name=spawn.$size					# file name we are working with
world=/home/mcserver/minecraft/world			# directory of the world
from="$(expr $size / -2) $(expr $size / -2)"		# start of region
to="$(expr $size / 2) $(expr $size / 2)"		# end of region

# header
echo -e "\e[32mUpdating spawn image:\e[0m size \e[92m$size\e[0m"

for direction in nw ne se sw; do			# generate for nw ne se sw
  # TODO if larger than 5000 then don't use other directions
  if [ $size -gt 5000 ] && [ $direction != nw ]; then exit; fi
  
  png=/home/share/mcmap/image/all/$name.$direction.$(date --iso).png	# the file we are creating
  link=/home/share/mcmap/image/$name.$direction.png			# link to todays file
  
  # create the map for the selected region
  ./mcmap/mcmap -min 50 -splits 8 -$direction -file "$png" -from $from -to $to "$world"
  
  # create link to the file in a clean dir
  if [ $? = 0 ]; then				# last command success
    if [ -s "$png" ]; then			# file exists and has a size greater than zero
      ln --force "$png" "$link" -v
    fi
  fi
done
