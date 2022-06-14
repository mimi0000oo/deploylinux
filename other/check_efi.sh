#!/bin/bash

#include files
source ./other/colors.sh
source ./prompts/option_prompt.sh 
source ./prompts/solve_optprompt.sh
source ./other/distro.sh
arch_create_partitions() { ./arch/create_partitions.sh; }
gentoo_create_partitions() { ./gentoo/create_partitions.sh; }
#include end

distro_choose() {
  if [ $distro = "archlinux" ]; then
    arch_create_partitions $1

  else 
    gentoo_create_partitions $1

  fi

}


if dmesg | grep -q "EFI v"; then
    echo efi
    distro_choose "efi enabled"

else 
    echo da
  option_prompt "${RED}Your system doesn't seem to have EFI/UEFI mode enabled!" "Reboot to change" "Keep going without EFI/UEFI" "It is a mistake, EFI/UEFI is enabled"
  read EFI
  solve_optprompt $EFI "reboot" "echo We keep going! Swiching to BIOS/Legacy partitioning format." "echo We sometimes make mistakes ok? Let's keep going with the EFI/UEFI partitioning format!"
  
  distro_choose $EFI

fi
