#! /bin/bash

# optional args :
# (1) infinitime OS directory
# (2) glime repo download location.

purple=$(printf '\033[1;35m')
green=$(printf '\033[1;32m')
yellow=$(printf '\033[1;33m')
bigGreen=$(printf '\033[30;102m')
reset=$(printf '\033[0m')

infi=$1
glime=$2

choice="y"
if [ -f $glime ]; then read -e -p "you've not specified a path to an existing glime download... shall this script download it for you? (notherwise.. this script terminate.) [y/n] " choice; fi
if [[ "$choice" != [Yy]* ]]; then exit 1; fi


if [ -f $infi ]; then infi="$(dirname $(readlink -f $0))/.."; fi
if [ -f $glime ]; then glime=$infi/glimeSupport/glime; git clone https://github.com/AndreiBoghean/glime.git $glime; fi

infi=$(readlink $infi -f)
glime=$(readlink $glime -f)

echo "${yellow}using infi: $infi${reset}"
echo "${yellow}using glime: $glime${reset}"

# "install" process

cd $infi

echo "${purple}setting up symlinks from infi->glime${reset}"
# insert the wrapper app which acts as the "barrier" between OS and external app.
# the wrapper app calls the main() of the external app.
ln -v -s $infi/glimeSupport/wrapApp.cpp $infi/src/displayapp/screens/wrapApp.cpp
ln -v $infi/glimeSupport/wrapApp.h $infi/src/displayapp/screens/wrapApp.h # using hardlink here because header includes seem to mess up with soft links.

# the external app that is OS-agnostic.
ln -v -s $glime/externApp.c $infi/src/displayapp/screens/externApp.cpp # note that we're hiding a c file as a cpp file, because glime only supports c but infinitime is cpp.
ln -v -s $glime/externApp.h $infi/src/displayapp/screens/externApp.h

# the InfiniTime-specific implementation for the compatability library
ln -v -s $infi/glimeSupport/compat.cpp $infi/src/compat.cpp
ln -v -s $glime/compat.h $infi/src/compat.h

# the Infinitime system component that provides services to the compatability implementation such as background timers.
mkdir -p $infi/src/components/compatProvider
ln -v -s $infi/glimeSupport/compatProvider.cpp $infi/src/components/compatProvider/compatProvider.cpp
ln -v -s $infi/glimeSupport/compatProvider.h $infi/src/components/compatProvider/compatProvider.h


echo "${green}done setting up symlinks from infi->glime${reset}"

echo "${bigGreen}finished integrating glime${reset}"
