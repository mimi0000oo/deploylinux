#!/bin/bash

#include files
source ./colors.sh
source ./create_prompt.sh 
#include end

check_efi () {

  if dmesg | grep -Fq "EFI v"; then
    printf "${RED}Your system doesn't seem to have EFI/UEFI mode enabled!"

  fi

}
