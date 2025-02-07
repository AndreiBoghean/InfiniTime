#! /bin/bash -xv

# download infinitime
git clone git@github.com:AndreiBoghean/InfiniTime.git

# download infinitime dependencies
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

cd -



# download wasp-os
git clone git@github.com:wasp-os/wasp-os.git
# download wasp-os dependencies

# download wasp-os dependencies
mkdir wasp_libs
cd wasp_libs
# x86_64 Linux hosted cross toolchains for an AArch32 bare-metal target (arm-none-eabi)
# from https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
# wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
url='https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2?revision=ca0cbf9c-9de2-491c-ac48-898b5bbc0443&rev=ca0cbf9c9de2491cac48898b5bbc0443&hash=72D7BCC38C586E3FE39D2A1DB133305C64CA068B'
$filename='gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2'
wget $url -O $filename
tar -xvf $filename

cd -
