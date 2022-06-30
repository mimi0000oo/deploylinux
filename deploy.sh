#!/bin/bash

# include files
distro="$(dmesg | grep "Linux version" | awk {' print $6 '} | sed -e 's/^([a-z]*@//' | sed -e 's/)//')"
# include end

if [ $distro = "archlinux" ]; then
  pacman -Sy --noconfirm wget unzip
  wget https://github.com/mimi0000oo/deploylinux/archive/testing.zip
  unzip testing.zip
  cd deploylinux-testing/
  rm ../deploy.sh
  ./setup.sh

else
  wget https://github.com/mimi0000oo/deploylinux/archive/testing.zip
  unzip testing.zip
  mkdir --parents /mnt/gentoo
  cp -r deploylinux-testing /mnt/gentoo
  /mnt/gentoo/deploylinux-testing/./setup.sh

fi
