XILINX_SDK="/opt/Xilinx/SDK/2017.4"
XILINX_VIVADO="/opt/Xilinx/Vivado/2017.4"
TMP_LOCATION="/home/getaz"
ORIGINAL_LOCATION=$PWD
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
source $XILINX_SDK/settings64.sh
source $XILINX_VIVADO/settings64.sh
DTC_COMPILE_SCRIPT=$ORIGINAL_LOCATION/output/build/linux-master/scripts/dtc/dtc
DTS_IN=$BASEDIR/dts/system-top.dts
DTB_OUT=$BINARIES_DIR/devicetree.dtb

echo "Start TCL script"
xsdk -batch $BASEDIR/run_hsi_cmds.tcl $BINARIES_DIR/fsbl $BASEDIR/snickerdoodle_hw_wrapper.hdf $BASEDIR 
echo "Finished TCL script"

cd $BINARIES_DIR
rm u-boot.elf
rm BOOT.bin
rm boot.bif
rm fsbl.elf

cp $BASEDIR/system.bit $BINARIES_DIR/system.bit
cp $BINARIES_DIR/fsbl/generated_fsbl/Debug/generated_fsbl.elf fsbl.elf
cp u-boot u-boot.elf
echo "Compile DTB ..."
$DTC_COMPILE_SCRIPT -I dts -O dtb -o $DTB_OUT $DTS_IN

cat <<EOF > boot.bif
image : {
  [bootloader] fsbl.elf
  system.bit
  u-boot.elf
}
EOF
bootgen -image boot.bif -arch zynq -o BOOT.bin

cd $ORIGINAL_LOCATION



