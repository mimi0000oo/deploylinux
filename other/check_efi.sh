#!/bin/bash

#include files
source ./other/colors.sh
source ./prompts/option_prompt.sh 
source ./prompts/solve_optprompt.sh
source ./other/distro.sh
source ./arch/create_partitions.sh
source ./gentoo/create_partitions.sh
#include end


if dmesg | grep -Fq "EFI v"; then
  option_prompt "${RED}Your system doesn't seem to have EFI/UEFI mode enabled!" "Reboot to change" "Keep going without EFI/UEFI" "It is a mistake, EFI/UEFI is enabled"
  read EFI
  solve_optprompt $EFI "reboot" "echo We keep going! Swiching to BIOS/Legacy partitioning format." "echo We sometimes make mistakes ok? Let's keep going with the EFI/UEFI partitioning format!"
  if [ $distro == "archlinux" ]; then
    arch_create_partitions $EFI

  else 
    gentoo_create_partitions $EFI

  fi

fi

