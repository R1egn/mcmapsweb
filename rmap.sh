#!/bin/bash

# Preset defaults for rendering maps by Region
#
# Usage ~/rmaps.sh X Z

#set variables
if [ -z $1 ]; then x=0; else x=$1; fi			# set to 0 0 if not provided 
if [ -z $2 ]; then z=0; else z=$2; fi			
name=r.$x.$z						# files we are working with (in mc and map)
world=/home/mcserver/minecraft/world			# directory of the world
mca=$world/region/$name.mca 				# region to load from mc
from="$(expr $x \* 512) $(expr $z \* 512)"		# start of region
to="$(expr $x \* 512 + 511) $(expr $z \* 512 + 511)"	# end of region

# header
echo -e "\e[32mUpdating image for region: $x.$z\e[0m blocks \e[92m$from to $to\e[0m"

# see if region exists - exit if not
if [ ! -f "$mca" ]; then
  echo -e "\e[33mRegion not yet explored nothing to do here.\e[0m"
  exit
fi

# generate for all 4 directions: nw ne se sw
for direction in nw ne se sw; do					
  # the file we are creating (TODO load date from mca file)
  png=/home/share/mcmap/image/all/$name.$direction.$(date --iso).png	
  # link to todays file
  link=/home/share/mcmap/image/$name.$direction.png			
  
  # see if region even needs to be updated - exit if not
  # NOTE verify that region dates are working (it looks like they update when 
  # minecraft server starts because of touch script)
  if [ $mca -ot $png ]; then
    echo -e "\e[33mRegion image ($direction) is up to date, exiting.\e[0m"
    exit
  fi
  
  # XXX This is failing. 2022-01-04
  # create the map for the selected region
  ./mcmap/mcmap -min 50 -splits 8 -$direction -file "$png" -from $from -to $to "$world"
  
  # create link to the file in a clean dir
  if [ $? = 0 ]; then		# last command success
    if [ -s "$png" ]; then	# file exists and has a size greater than zero
      ln --force "$png" "$link" -v
      # later this could match format required by viewer program
    fi
  fi
done
