# lfl-create - The Little Favourite Launcher for RetroPie

coded by cyperghost
06/21/17

# What this?
This piece of software automatically creates favourites to your beloved ROMs and store it in your favourite folder.
All you need to tell lfl-create is
1. Where are your Favourites stored?
2. What ROM do you want to run?
3. What is the systems name?
4. What cmdline is used to run a ROM (optional as last ressort if nothing works!)

So if you tell lfl-create you want to favour Tetris then do it like this.

`./lfl-create "/home/pi/RetroPie/roms/My Favourites" "/home/pi/RetroPie/roms/gb/Tetris (JUE) 1.1.gb" "gb"`

After this a FAV file is created into folder My Favourites and it is named `GB - Tetris (JUE) 1.1.FAV`

# How to compile
lfl-create was written in FreeBasic.
So grab your copy of FreeBasic for ARMv6 and install...
to compile use
`fbc yourbasicprogram.bas` and a binary is created into the same folder

I also offer the precombiled binaries in the download archive.

# What are FAV files?
FAV is a creation by me. In old old old times as the internet was empty space it was used to be good style to use
description and info files on BB-systems. You could read them and later (during night) you activated a download to
get a software you want. The DIZ and NFO files were a short description of the distributor of the software
and also offered version number, system depedencies and other usefull information.

The the retro idea was born to use description files for a favourite launcher system.

If we open that file every information is introduced here
_First line gives the full ROM-path_
`/home/pi/RetroPie/roms/gb/Tetris (JUE) 1.1.gb`

_Second line gives system Name_
`gb`

_Third line gives command call - this is only for deep digging if there is a failure in processing.... Usually line 1 and 2 are enough (empty in our example usually filled with above by automatic process)_
`/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-gambatte/gambatte_libretro.so --config /opt/retropie/configs/gb/retroarch.cfg "/home/pi/RetroPie/roms/gb/Tetris (JUE) 1.1.gb"`

The name lfl-create is indeed a bit misleading! It's not just a creator it is also a lauchner and is able to decode the FAV files and run them like the runcommand.sh did.

## Prerequisite #1
Push RetroPie-Setup to version 4.2.8 (version from 06/16/17)
Go to RetroPie menu and select and run "RetroPie Setup", Update RetroPie-Setup
This will cause to get a "User Menu" in runcommand.sh if we press a button during the grey loading box appears....

## Prerequisite #2
Create a system "My Favourites" in es_system.cfg
Therefore edit es_systems.cfg and add code block
  
```
  <system>
    <name>favourites</name>
    <fullname>Favourites</fullname>
    <path>/home/pi/RetroPie/roms/fav123456789012345</path>
    <extension>.fav .FAV</extension>
    <command>/opt/retropie/supplementary/runcommand/lfl-create %ROM%</command>
    <platform>all</platform>
    <theme>favourites</theme>
  </system>
``` 

## Prerequisite #3
Compile the binary or copy the delivered binary to /opt/retropie/supplementary/runcommand/
the binary should be named lfl-create, please check if settings managment is right - file must be executable

## Prerequisite #4
Copy file runcommand_systems.txt to your favourite folder.
This file is necessary because here are the launching commands for each system deposited.

If your favourite folder is also located in the ROM folder then the FAVs files are available wie SMB in Windows for ex. so you can also use Windows to locate runcommand_systems.txt there.
I think that future version should be read out the commands through es_system.cfg but well I'm not affinated to do this and I know that this is a dirty quirk.

But the advantages are clear: There is no difference between lauchching the ROM directly from it's system selection or if you run it by FAV call.

## Prerequisite #5
Last step ... madame e misseu
The wonderfull User Menu!
create folder runcommand-menu in /opt/retropie/configs/all

Place the User Menu scripts in

Content of `Create Favourite.sh`

```
#!/bin/bash
#Add favourites to definated folder
#by cyperghost 06/21/17
#FAV folder is the first parameter given to binary lfl-create
#for ex. lfl-create "/home/pi/RetroPie/My Favourites" let's store all favourites to "My Favourites"
#
#Usage and parameters:
#Scripts get called like this: bash "$script" "$system" "$emulator" "$rom" "$command"
#So script is the root dir, $system=$1, $emulator=$2, $rom=$3 and $command=$4 

# full command
# first parameter gives location to your favourite folder ... be sure last character is /
# Please don't change order of parameters! This will cause conflicts!

/opt/retropie/supplementary/runcommand/lfl-create "/home/pi/RetroPie/roms/My Favourites/" "$3" "$1" "$4"
sleep 5
```
Content of `Delete Favourite.sh`

```
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
```

Take care of owners rights! User Pi and status X (=755) must be setted.

Restart Emulationstation!
Enjoy your Favourites

BTW: You can create more than one favourites folder - one for the MAME ROW, one for Arcade/NeoGeo, one for Consoles, one for HPC....

With best wishes and feel free to ask or give contributions
Please respect the work of others!

# Version History

_Intital version 0.1 created on 06/08/17_
* Just launching ability and a test what can be done in simple coding
* Just released for laughing....
* released for testing purposed into unix system! 
* The name lfl-create was used in future version

_version 0.15 created 06/12/17_
* Initial version for lfl-create $ROM $SYSTEM and $COMMAND were used and processed
* Created a FAV file with only $COMMAND inside
* launch was initiated just via BASH call from ES
* Worked also but is dirty and gives a lot of errors
* First version for public

_version 0.55 created 06/13/17_
* Heavy rework because of using runcommand_systems.txt to initiate 1:1 behaviour to usual launch
* lfl-creates acts as launcher and creater now
* Nicer looking favnames (SYSTEM - romname)
* Favnames or now lowercase
* FAVs can called by bash if there is no description available (rename .sh files from ports to .fav and copy them to Favourite folder)

_Version 0.65 created 06/15/17_
* FAVs can now be deleted by double adding ROM to favourite, First add creates FAV file, second deletes, third creates....
* FAVs deletion will be indicated by small text message!
* Never released

Version 0.75 created 21/06/17
* Added -DEL Parameter to delete FAVs (if they exists), instead of $4 or $Command use "-del"
* Never released a bit bogus in the code (to much if and then)

version 0.85 created 21/17/17
* Nicer selections via case values
* Gives output to the user happened
  FAV file deleted
  FAV file created
  FAV file already there - do nothing! 
* Rewritten for RetroPie 4.2 and it's User Menu
