#!/bin/bash

# loop through and start making maps

# spawn area maps in background 41s; ~2m; 2.5m
./map.sh 2000 && ./map.sh 4000 && ./map.sh 7500 &

# generate using region files ~28m 
for region_file in /home/mcserver/minecraft/world/region/*.mca; do
  $(echo $region_file | perl -pe "s/^.*r\.([0-9-]+)\.([0-9-]+)\.mca/.\/rmap.sh \1 \2/")
done

wait
# The huge map ~12m
map.sh 10000

# Tidy up the files
cleanmaps.sh
