#!/bin/bash

# include files
source ./other/distro.sh
# include end

if [ $distro == "archlinux" ]; then
  pacman -Sy --noconfirm wget unzip
  wget https://github.com/mimi0000oo/deploylinux/archive/testing.zip
  unzip testing.zip
  cd deploylinux-testing/
  rm ../deploy.sh
  ./setup.sh

else
  wget https://github.com/mimi0000oo/deploylinux/archive/testing.zip
  unzip testing.zip
  cd deploylinux-testing/
  rm ../deploy.sh
  ./setup.sh

fi
