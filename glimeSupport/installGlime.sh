#! /bin/bash

# optional args :
# (1) infinitime OS directory
# (2) glime repo download location.

infi=$1
glime=$2

if [ -f $infi ]; then infi="$(dirname $(readlink -f $0))/.."; fi
if [ -f $glime ]; then git clone git@github.com:AndreiBoghean/glime.git; glime=$infi/glimeSupport/glime; fi

infi=$(readlink $infi -f)
glime=$(readlink $glime -f)

echo "infi: $infi"
echo "glime: $glime"

# "install" process

cd $infi
npm install lv_font_conv

# insert the wrapper app which acts as the "barrier" between OS and external app.
# the wrapper app calls the main() of the external app.
ln -v -s $(readlink $infi/glimeSupport/wrapApp.cpp -f) $infi/src/displayapp/screens/wrapApp.cpp
ln -v $(readlink $infi/glimeSupport/wrapApp.h -f) $infi/src/displayapp/screens/wrapApp.h # using hardlink here because header includes seem to mess up with soft links.

# the external app that is OS-agnostic.
ln -v -s $(readlink $glime/externApp.cpp -f) $infi/src/displayapp/screens/externApp.cpp
ln -v -s $(readlink $glime/externApp.h -f) $infi/src/displayapp/screens/externApp.h

# the InfiniTime-specific implementation for the compatability library
ln -v -s $(readlink $infi/glimeSupport/compat.cpp -f) $infi/src/compat.cpp
ln -v -s $(readlink $glime/compat.h -f) $infi/src/compat.h

# the Infinitime system component that provides services to the compatability implementation such as background timers.
mkdir -p $infi/src/components/compatProvider
ln -v -s $(readlink $infi/glimeSupport/compatProvider.cpp -f) $infi/src/components/compatProvider/compatProvider.cpp
ln -v -s $(readlink $infi/glimeSupport/compatProvider.h -f) $infi/src/components/compatProvider/compatProvider.h
