#!/bin/bash

# include files
source ./gentoo/achroot/mount_root.sh
source ./gentoo/achroot/configure_portage.sh
source ./gentoo/achroot/choose_profile.sh
source ./gentoo/achroot/cpu_flags.sh
source ./gentoo/achroot/update_world.sh
source ./gentoo/achroot/timezone.sh
source ./gentoo/achroot/conf_locale.sh
# include end
cd /deploylinux-testing
source /etc/profile
export PS1="(chroot) ${PS1}"

mount_root

configure_portage

choose_profile

update_world

cpu_flags

timezone

conf_locale
