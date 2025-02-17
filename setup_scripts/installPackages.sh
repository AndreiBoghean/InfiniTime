#! /bin/bash

purple=$(printf '\033[1;35m')
green=$(printf '\033[1;32m')
bigGreen=$(printf '\033[30;102m')
reset=$(printf '\033[0m')

cd $(dirname $(readlink -f $0))/.. # move into InfiniTime folder, relative to this script's location in InfiniTime/setup_scripts
# ^ needed since pip below uses a relative link for reqs.txt

echo "${purple}installing packages base-devel and unzip${reset}"
sudo pacman -Sy npm base-devel cmake unzip
echo "${green}finished installing system packages${reset}"

echo "${purple}installing python packages${reset}"
pip install --break-system-packages -r tools/mcuboot/requirements.txt
pip install --break-system-packages adafruit-nrfutil
echo "${green}finished installing python packages${reset}"

echo "${bigGreen}finished installing packages${reset}"
