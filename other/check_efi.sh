#!/bin/bash

#include files
source ./colors.sh
source ../prompts/create_prompt.sh 
source ../prompts/solve_optprompt.sh
source ./distro.sh
arch_create_partitions() { ../arch/create_partitions.sh; }
gentoo_create_partitions() { ../gentoo/create_partitions.sh; }
#include end


if dmesg | grep -Fq "EFI v"; then
  create_prompt "${RED}Your system doesn't seem to have EFI/UEFI mode enabled!" "Reboot to change" "Keep going without EFI/UEFI" "It is a mistake, EFI/UEFI is enabled"
  read EFI
  solve_optprompt $EFI "reboot" "echo We keep going! Swiching to BIOS/Legacy partitioning format." "echo We sometimes make mistakes ok? Let's keep going with the EFI/UEFI partitioning format!"
  if [ $distro == "archlinux" ]; then
    arch_create_partitions $EFI

  else 
    gentoo_create_partitions $EFI

  fi

fi

