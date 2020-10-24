#!/bin/bash

# loop through and start making maps

# spawn area maps in background 41s; ~2m; 2.5m
/home/mcserver/map.sh 2000 && /home/mcserver/map.sh 4000 && /home/mcserver/map.sh 7500 &

# generate using region files ~28m 
for region_file in /home/mcserver/minecraft/world/region/*.mca; do
  $(echo $region_file | perl -pe "s/^.*r\.([0-9-]+)\.([0-9-]+)\.mca/\/home\/mcserver\/rmap.sh \1 \2/")
done

wait
# The huge map ~12m
/home/mcserver/map.sh 10000

# Tidy up the files
/home/mcserver/cleanmaps.sh
