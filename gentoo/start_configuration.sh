#!/bin/bash

#include files
source ./other/colors.sh
create_partitions() { ./gentoo/create_partitions.sh; }
source ./gentoo/install_stage.sh
source ./gentoo/conf_compile_opt.sh
source ./gentoo/chroot_prepare.sh
#include end

create_partitions

install_stage

conf_compile_opt

chroot_prepare

chroot /mnt/gentoo /mnt/gentoo/deploylinux-testing/gentoo/achroot/start_chroot.sh
