#! /bin/bash
# a script to download infinitime dependencies and also the emulator, placing them in InfiniTime/infi_libs folder.

cd $(dirname $(readlink -f $0))/.. # move into InfiniTime folder, relative to this script's location in InfiniTime/setup_scripts
# ^ assume the script is being executed from some arbitrary path.

sudo npm install lv_font_conv

mkdir infi_libs
cd infi_libs

# gcc arm compiler for linux x86-64 from https://developer.arm.com/downloads/-/gnu-rm/10-3-2021-10
url='https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2?rev=78196d3461ba4c9089a67b5f33edf82a&hash=D484B37FF37D6FC3597EBE2877FB666A41D5253B'
filename='gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2'
wget $url -O $filename
tar -xvf $filename

# nordic semiconductor nRF52 SDK 15.3.0
url='https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.3.0_59ac345.zip'
filename='nRF5_SDK_15.3.0_59ac345.zip'
wget $url -O $filename
unzip $filename

# clone the emulator for ininitime
# git clone git@github.com:pipe01/InfiniEmu.git
echo "dependency downloading should now be complete and present within $(pwd)"
echo "note: to be able to use the emulator with the provided build script,"
echo "please download the latest infiniemu build from https://github.com/pipe01/InfiniEmu/"
echo "and place it's contents within $(pwd)/infiniemu"
echo "also note that the latest build this project supports is from pipeline #113"
