#! /bin/bash

# optional args :
# (1) infinitime OS directory
# (2) glime repo download location.

infi=$1
glime=$2

if [ -f $infi ]; then infi="$(dirname $(readlink -f $0))/.."; fi
if [ -f $glime ]; then glime=$infi/glimeSupport/glime; git clone https://github.com/AndreiBoghean/glime.git $glime; fi

infi=$(readlink $infi -f)
glime=$(readlink $glime -f)

echo "infi: $infi"
echo "glime: $glime"

# "install" process

cd $infi

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
