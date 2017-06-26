' Favourite creater 0.85
' 06/21/17 by cyperghost
' greetings to vika, meleu, cott, buzz, seklth
' this is a full functional version
' wait for more features!
' 
' Added:
' Nicer looking favnames (SYSTEM - romname)
' launch abilitiy close to runcommand.sh
' Favnames or now lowercase
' FAVs can called by bash if there is no description available (rename .sh files from ports to .fav and copy them to Favourite folder)
' FAVs will be deleted by specific call via "-del" Parameter as LAST parameter, if there is no FAV-file present nothing happens
' FAVs will not be created if there is a file already present, to get rid of this use "-del" parameter as last
' FAVs deletion will be indicated by small text message!
'
' TODO vor version 1.0: Read out <command> list directly from es_systems.cfg
' 
' This is my last release of Favourite creater for RetroPie
' 
' In the near future favourite support may be in ES
' Personally I created this piece of software to favourite MAME ROWs
' 
' Please feel free to contribute
' but
' Respect the work of others!

#INCLUDE "vbcompat.bi" 'Needed for FILEEXISTS()
dim as string path_fav,rom_fav, system_fav, rom_name, rom_favname, runcommand, sysbash
dim as integer idx, z

' Codeblock for debug: what commands are used
' Uncomment for debug
'print "ROOT DIR: ";command(0)
'print "FAV PATH: ";command(1)
'print "ROM PATH: ";command(2)
'print "ROM SYST: ";command(3)
'print "SYS CALL: ";command(4)

select case ucase(right(command(1),4))
case ".FAV" 'Act as launcher for FAV files
rom_favname=command(1)

open rom_favname for input as #1
line input #1,rom_name
line input #1,system_fav
line input #1,sysbash
close #1


for z=1 to len(rom_favname)
if mid(rom_favname,z,1)="/" then idx=z
next z
path_fav=left(rom_favname,idx)

open path_fav+"runcommand_systems.txt" for input as #1
do
line input #1,runcommand
loop until eof(1) or InStr(runcommand,system_fav)<>0
close #1

If InStr(runcommand,system_fav)=0 and sysbash<>"" then shell sysbash:end
If InStr(runcommand,system_fav)=0 then shell "bash "+chr(34)+rom_favname+chr(34):end


sysbash=mid(runcommand,1,InStr(runcommand, "%ROM%")-1)+chr(34)+rom_name+chr(34)+Mid(runcommand,InStr(runcommand, "%ROM%")+Len("%ROM%"),Len(runcommand))
shell sysbash

case else 'create or delete fav-files
path_fav=command(1)
rom_fav=command(2)
system_fav=command(3)
sysbash=command(4)

for z=1 to len(rom_fav)
if mid(rom_fav,z,1)="/" then idx=z
next z

rom_name=mid(rom_fav,idx+1,len(rom_fav))

for z=1 to len(rom_name)
if mid(rom_name,z,1)="." then idx=z
next z

rom_favname=ucase(system_fav)+" - "+left(rom_name,idx-1)+".fav"

'possibility to kill and add favorites
'Build FAV file
'FILEEXISTS knows two states -1 for file not found, 0 for file found

select case fileexists (path_fav+rom_favname)
case -1
if ucase(sysbash)="-DEL" then 
kill path_fav+rom_favname
print "FAV file deleted: "& rom_favname
else
print "FAV file "& rom_favname &" already exists. Nothing happend!"
end if


case 0
open path_fav+rom_favname for output as #1
print #1, rom_fav
print #1, system_fav
print #1, sysbash
close #1
print "FAV file "& rom_favname &" created in "& path_fav
end select
end select