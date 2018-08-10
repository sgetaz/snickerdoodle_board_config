BOOT_SD_DIR="/media/getaz/BOOT2"
ROOTFS_SD_DIR="/media/getaz/ROOTFS"
BINARIES_DIR="/home/getaz/Documents/Code/snickerdoodle-dev/buildroot/output/images"


sudo rm -rf $ROOTFS_SD_DIR/*

sudo tar -C $ROOTFS_SD_DIR -xvf $BINARIES_DIR/rootfs.tar
