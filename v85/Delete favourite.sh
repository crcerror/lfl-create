#!/bin/bash
#Delete favourites to definated folder
#by cyperghost 06/21/17
#FAV folder is the first parameter given to binary lfl-create
#for ex. lfl-create "/home/pi/RetroPie/My Favourites" deletes the "$SYSTEM - $rom.FAV" entry in "My Favourites"
#the only difference is that at last parameter the -del command is written
#
#Usage and parameters:
#Scripts get called like this: bash "$script" "$system" "$emulator" "$rom" "$command"
#So script is the root dir, $system=$1, $emulator=$2, $rom=$3 and $command=$4 

# full command
# first parameter gives location to your favourite folder ... be sure last character is /
# Please don't change order of parameters! This will cause conflicts!


/opt/retropie/supplementary/runcommand/lfl-create "/home/pi/RetroPie/roms/My Favourites/" "$3" "$1" "-DEL"
sleep 5