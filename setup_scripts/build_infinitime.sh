#! /bin/bash

# args:
# (1) - either "quick" or anything else; specifies whether to do a full rebuild or just compile.
# (2) - either "emu" or anything else; specifies whether to build for the emulator and run it.

# infi_dir="$(pwd)/$(find -name "InfiniTime" | grep "andrei" -v)"
# infi_libs="$(pwd)/$(find -name "infi_libs" | grep "andrei" -v | head -1)" # head -1 needed because of unexplained dir copying wierdness.
infi_dir="$(dirname $(readlink -f $0))/.."
infi_libs="$infi_dir/infi_libs"

echo "$infi_dir"
echo "$infi_libs"

cd $infi_dir

git submodule update --init

if [[ "$1" != "quick" ]]; then rm -rf build; fi
mkdir -p build
cd build

folderName=$(basename $PWD)
if [[ $folderName != "build" ]]
then
	echo "WARNING: not in build directory; exiting..."
	exit 1
fi

toolchain="$infi_libs/gcc-arm-none-eabi-10.3-2021.10/"
sdk="$infi_libs/nRF5_SDK_15.3.0_59ac345/"
echo "toolchain" "$toolchain"
echo "sdk" "$sdk"


if [[ "$1" != "quick" ]]; then cmake ../ -DARM_NONE_EABI_TOOLCHAIN_PATH=$toolchain -DNRF5_SDK_PATH=$sdk -DBUILD_DFU=1 -DBUILD_RESOURCES=1 -DENABLE_USERAPPS="Apps::wrapApp, Apps::Paint, Apps::HeartRate, Apps::Timer"; fi
echo $(pwd)

if [[ $2 != "emu" ]]
then
	make -j4 pinetime-mcuboot-app
else
	make -j4 pinetime-app
	# /home/andrei/uniY4/IndivProj/OSes/infiniEmu/infiniemu ./src/pinetime-app*.bin
	$infi_libs/infiniemu/infiniemu ./src/pinetime-app*.bin
fi
