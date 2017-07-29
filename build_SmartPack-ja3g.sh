#!/bin/bash

echo -e $COLOR_GREEN"\n SmartPack Kernel Build Script\n"$COLOR_NEUTRAL
#
echo -e $COLOR_GREEN"\n (c) sunilpaulmathew@xda-developers.com\n"$COLOR_NEUTRAL

TOOLCHAIN="/home/sunil/android-ndk-r13b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-"
ARCHITECTURE=arm

NUM_CPUS=""   # number of cpu cores used for build (leave empty for auto detection)

export ARCH=$ARCHITECTURE
export CROSS_COMPILE="${CCACHE} $TOOLCHAIN"

if [ -z "$NUM_CPUS" ]; then
	NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
fi

# creating backups

cp scripts/mkcompile_h release_SmartPack/

# updating kernel name

sed "s/\`echo \$LINUX_COMPILE_BY | \$UTS_TRUNCATE\`/SmartPack-Kernel-ja3g-[sunilpaulmathew/g" -i scripts/mkcompile_h
sed "s/\`echo \$LINUX_COMPILE_HOST | \$UTS_TRUNCATE\`/xda-developers.com]/g" -i scripts/mkcompile_h

echo -e $COLOR_GREEN"\n building Smartpack kernel for ja3g\n"$COLOR_NEUTRAL

mkdir output_eur

make -C $(pwd) O=output_eur lineageos_ja3gxx_defconfig && make -j$NUM_CPUS -C $(pwd) O=output_eur

echo -e $COLOR_GREEN"\n Copying zImage to generate boot.img\n"$COLOR_NEUTRAL

cp output_eur/arch/arm/boot/zImage ja3g/LOS/kernel && cp output_eur/arch/arm/boot/zImage ja3g/RR/kernel

echo -e $COLOR_GREEN"\n Generating boot.img\n"$COLOR_NEUTRAL

cd ja3g/ && perl mkboot LOS/ ../recovery-zip_SmartPack/boot.img

echo -e $COLOR_GREEN"\n Making recovery flashable zip for LineageOS -ja3g\n"$COLOR_NEUTRAL

cd ../recovery-zip_SmartPack/ && zip -r9 SmartPack_kernel-LOS_ja3g_beta_$(date +"%Y%m%d").zip * && mv SmartPack_* ../release_SmartPack/ && rm boot.img

echo -e $COLOR_GREEN"\n Generating boot.img\n"$COLOR_NEUTRAL

cd ../ja3g/ && perl mkboot RR/ ../recovery-zip_SmartPack/boot.img

echo -e $COLOR_GREEN"\n Making recovery flashable zip for RR -ja3g\n"$COLOR_NEUTRAL

cd ../recovery-zip_SmartPack/ && zip -r9 SmartPack_kernel-RR_ja3g_beta_$(date +"%Y%m%d").zip * && mv SmartPack_* ../release_SmartPack/ && rm boot.img

echo -e $COLOR_GREEN"\n Cleaning\n"$COLOR_NEUTRAL

cd .. && rm ja3g/LOS/kernel && rm ja3g/RR/kernel

# restoring backups

mv release_SmartPack/mkcompile_h scripts/

echo -e $COLOR_GREEN"\n Everything done... please visit 'release_SmartPack'\n"$COLOR_NEUTRAL
