#!/bin/bash

# Definitions
KERNEL_DIR=`pwd`
KERNEL_MERGE_DIR=$KERNEL_DIR/repack_Illusion
KERNEL_ZIP_DIR=$KERNEL_DIR/recovery-zip_Illusion
KERNEL_RELEASE_DIR=$KERNEL_DIR/release_Illusion
mkbootimg="$KERNEL_MERGE_DIR/mkbootimg"
mkbootimg_args="--base 0x10000000 \
    --kernel_offset 0x00008000 \
    --ramdisk_offset 0x01000000 \
    --tags_offset 0x00000100 \
    --cmdline buildvariant=userdebug \
    --pagesize 2048"
NUM_CPUS=""


# Be ready for build
echo -e $COLOR_GREEN"\n Preparing...\n"$COLOR_NEUTRAL
mkdir release_Illusion


# Build kernel
echo -e $COLOR_GREEN"\n Start building kernel\n"$COLOR_NEUTRAL
export ARCH=arm
export CROSS_COMPILE=/home/illusion/toolchain/hyper/bin/arm-eabi-
if [ -z "$NUM_CPUS" ]; then
	NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
fi
make illusion_defconfig && make -j$NUM_CPUS


# Move zImage to merge folder
echo -e $COLOR_GREEN"\n Making zip file\n"$COLOR_NEUTRAL
cp $KERNEL_DIR/arch/arm/boot/zImage $KERNEL_MERGE_DIR/kernel/boot.img-zImage


# Merge kernel
cd $KERNEL_MERGE_DIR
$mkbootimg $mkbootimg_args \
    --kernel $KERNEL_MERGE_DIR/kernel/boot.img-zImage \
    --ramdisk $KERNEL_MERGE_DIR/kernel/boot.img-ramdisk.cpio.lzma \
    -o $KERNEL_MERGE_DIR/new.img


# Move new.img to zip folder
cp $KERNEL_MERGE_DIR/new.img $KERNEL_ZIP_DIR/boot.img


# Zipping kernel
cd $KERNEL_ZIP_DIR
zip -r9 Illusion_kernel-LOS_jalteskt_$(date +"%Y%m%d").zip * && mv Illusion_* $KERNEL_RELEASE_DIR


# Cleaning
echo -e $COLOR_GREEN"\n Cleaning directory\n"$COLOR_NEUTRAL
cd .. && rm $KERNEL_MERGE_DIR/kernel/boot.img-zImage && rm $KERNEL_MERGE_DIR/new.img && rm $KERNEL_ZIP_DIR/boot.img


# Complete!
echo -e $COLOR_GREEN"\n Everything done. Your file will be at 'release_Illusion'\n"$COLOR_NEUTRAL
