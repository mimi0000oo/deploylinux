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
  mkdir --parents /mnt/gentoo
  wget https://github.com/mimi0000oo/deploylinux/archive/testing.zip -P /mnt/gentoo
  unzip /mnt/gentoo/testing.zip -d /mnt/gentoo
  rm ./deploy.sh
  cd /mnt/gentoo/deploylinux-testing/
  ./setup.sh

fi
