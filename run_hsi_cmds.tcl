set FSBL_BuildDir [lindex $argv 0]
set HDF_Source [lindex $argv 1]
set Script_Dir [lindex $argv 2]

setws -switch $Script_Dir
after 1000

exec mkdir -p $FSBL_BuildDir
file delete -force -- $FSBL_BuildDir
after 1000

exec mkdir -p $FSBL_BuildDir
exec cp $HDF_Source $FSBL_BuildDir/
cd $FSBL_BuildDir

setws -switch .
after 1000

createhw -name hw0 -hwspec $HDF_Source
createapp -name generated_fsbl -app {Zynq FSBL} -proc ps7_cortexa9_0 -hwproject hw0 -os standalone -lang c -arch 64
projects -build

closehw hw0

cd $Script_Dir
