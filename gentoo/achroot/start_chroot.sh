#!/bin/bash

# include files
source ./mount_root.sh
source ./configure_portage.sh
source ./choose_profile.sh
source ./cpu_flags.sh
source ./update_world.sh
source ./timezone.sh
source ./conf_locale.sh
# include end

source /etc/profile
export PS1="(chroot) ${PS1}"

mount_root

configure_portage

choose_profile

update_world

cpu_flags

timezone

conf_locale
