#!/bin/bash

echo -e $COLOR_GREEN"\n Illusion Kernel Build Script\n"$COLOR_NEUTRAL
#
echo -e $COLOR_GREEN"\n (c) sunilpaulmathew@xda-developers.com\n"$COLOR_NEUTRAL

TOOLCHAIN="/home/illusion/toolchain/hyper/bin/arm-eabi-"
ARCHITECTURE=arm

NUM_CPUS=""   # number of cpu cores used for build (leave empty for auto detection)

export ARCH=$ARCHITECTURE
export CROSS_COMPILE="${CCACHE} $TOOLCHAIN"

if [ -z "$NUM_CPUS" ]; then
	NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
fi

# creating backups

cp scripts/mkcompile_h release_Illusion/

# updating kernel name

sed "s/\`echo \$LINUX_COMPILE_BY | \$UTS_TRUNCATE\`/illusion/g" -i scripts/mkcompile_h
sed "s/\`echo \$LINUX_COMPILE_HOST | \$UTS_TRUNCATE\`/illusion/g" -i scripts/mkcompile_h

echo -e $COLOR_GREEN"\n Building Illusion Kernel for jalteskt\n"$COLOR_NEUTRAL

mkdir output_Illusion

make -C $(pwd) O=output_Illusion illusion_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_Illusion

echo -e $COLOR_GREEN"\n Copying zImage to generate boot.img\n"$COLOR_NEUTRAL

cp output_Illusion/arch/arm/boot/zImage jalte/skt/kernel

echo -e $COLOR_GREEN"\n Generating boot.img\n"$COLOR_NEUTRAL

cd jalte/ && perl mkboot skt/ ../recovery-zip_Illusion/boot.img

echo -e $COLOR_GREEN"\n Making recovery flashable zip for LineageOS -jalteskt\n"$COLOR_NEUTRAL

cd ../recovery-zip_Illusion/ && zip -r9 Illusion_kernel-LOS_jalteskt_beta_$(date +"%Y%m%d").zip * && mv Illusion_* ../release_Illusion/ && rm boot.img

echo -e $COLOR_GREEN"\n Cleaning\n"$COLOR_NEUTRAL

cd .. && rm jalte/skt/kernel

# restoring backups

mv release_Illusion/mkcompile_h scripts/

echo -e $COLOR_GREEN"\n Everything done... please visit 'release_Illusion'\n"$COLOR_NEUTRAL
