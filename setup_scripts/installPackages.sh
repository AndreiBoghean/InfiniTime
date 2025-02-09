#! /bin/bash

cd $(dirname $(readlink -f $0))/.. # move into InfiniTime folder, relative to this script's location in InfiniTime/setup_scripts
# ^ needed since pip below uses a relative link for reqs.txt

sudo pacman -Sy npm base-devel cmake unzip
pip install --break-system-packages -r tools/mcuboot/requirements.txt
pip install --break-system-packages adafruit-nrfutil
