' Favourite creater 0.55
' 06/13/17 cyperghost
' greetings to vika, meleu, cott, buzz, seklth
' this is just a small test
' wait for more
' 
' Added:
' Nicer looking favnames (SYSTEM - romname)
' launch abilitiy close to runcommand.sh
' Favnames or now lowercase
' FAVs can called by bash if there is no description available (rename .sh files from ports to .fav and copy them to Favouirite folder)

dim as string path_fav,rom_fav, system_fav, rom_name, rom_favname, runcommand, sysbash
dim as integer idx, z

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

If InStr(runcommand,system_fav)=0 and sysbash<>"" then shell chr(34)+sysbash+chr$(34):end
If InStr(runcommand,system_fav)=0 then shell "bash "+chr(34)+rom_favname+chr(34):end


sysbash=mid(runcommand,1,InStr(runcommand, "%ROM%")-1)+chr(34)+rom_name+chr(34)+Mid(runcommand,InStr(runcommand, "%ROM%")+Len("%ROM%"),Len(runcommand))
shell sysbash

case else 'create fav-files
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

' Build FAV file
open path_fav+rom_favname for output as #1
print #1, rom_fav
print #1, system_fav
print #1, sysbash
close #1

end select