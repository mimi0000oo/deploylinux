#!/bin/bash

# include fils
source ./other/colors.sh
# include end

chroot_prepare() {
  cp ../deploylinux-testing /mnt/gentoo/
  printf "${GREEN} Choose the closest sources to your location!"
  sleep 10
  
  mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf

  mkdir --parents /mnt/gentoo/etc/portage/repos.conf

  cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf

  cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

  mount --types proc /proc /mnt/gentoo/proc
  mount --rbind /sys /mnt/gentoo/sys
  mount --make-rslave /mnt/gentoo/sys
  mount --rbind /dev /mnt/gentoo/dev
  mount --make-rslave /mnt/gentoo/dev
  mount --bind /run /mnt/gentoo/run
  mount --make-slave /mnt/gentoo/run 
  
}
