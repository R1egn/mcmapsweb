# The web frontend to view stiched together mcmaps.

## Bugs
1. Layout maps clean without having to drag around to align them first.  
   This is a javascript change, something on the page load.

## NOTES
1. Many of the files are hard linked on the server. When this is done it 
   would be great if they were no longer hard linked.

## TODO
1. Move around while swapping maps in/out of the browser window automatically 
   in the background. Perhaps need to keep track of blocks that are visible and 
   when they leave the screen then add more to the side.
1. Add option to go to coords.
1. Move scripts to their own file? (\*.js?)
1. Add ability to rotate map.
1. Add ability to name places??? (That's a big deal.)
1. Show where players are (or were last).

## DONE
1. Move images into image directory.
1. Create website using Apache at chloe using default web port. It can 
   default to the share directory /home/share/mcmap/draw9.html.
1. Can drag the map around like google maps.
1. Add to github.
1. Move into project including \*.sh for creating the maps.
1. Format this file
