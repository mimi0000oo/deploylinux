#!/bin/bash

# include files
source ./prompts/option_prompt.sh
source ./prompts/solve_optprompt.sh
source ./other/colors.sh
check_efi() { ./other/check_efi.sh; }
# include end

create_partitions() {
  if [ !$1 ]; then 
    check_efi

  else 

    if [ $1 == 2 ]; then #bios option

      select_drive() {

        printf ${WHITE}"This is your curent configuration:\n${MAGENTA}$(lsblk -o MODEL,NAME,SIZE,TYPE,MOUNTPOINTS,HOTPLUG)"
        option_prompt "Which drive do you want to install Gentoo on?"
        read drive
        printf ${CYAN}"You selected drive ${YELLOW}\"$drive\""
        
        select_partition_route() {

          option_prompt "What do you want to do from here?" "Go with predefined partitions" "Create your own partitions" "Back" "Quit"
          read partitions
          predefined_partitions="NAME   SIZE    TYPE    MOUNTPOINTS\n \
            sda    $(lsblk | grep $drive -m1 | awk {' print $4 '})    disk\n \
            sda1    256M    EFI System    /boot\n \
            sda2    4G    Linux Swap    [SWAP]\n \
            sda3  $(( $(( $(lsblk -b | grep $drive -m1 | awk {' print $4 '}) - (256 * 1048576) - (4 * 1024 * 1048576) )) / 1073741824 ))G    Linux filesystem    /"
          
          solve_optprompt $partitions "echo The predefined partitions are:\n$predefined_partitions"

        }

      }
      
      select_drive
    
    else
      echo to do

    fi
  
  fi

}
