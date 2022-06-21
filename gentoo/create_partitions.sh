#!/bin/bash

# include files
source ./prompts/option_prompt.sh
source .import_configurationts/solve_optprompt.sh
source ./prompts/yn_prompt.sh
source ./prompts/solve_ynprompt.sh
source ./other/colors.sh
check_efi() { ./other/check_efi.sh; }
# include end



if [ "$1" = 2 ]; then # bios mode

  select_drive() {
    
    drives="$(lsblk -o MODEL,NAME,SIZE,TYPE,MOUNTPOINTS,HOTPLUG | grep disk)"
    drivenr="$(lsblk -o MODEL,NAME,SIZE,TYPE,MOUNTPOINTS,HOTPLUG | grep -c disk)"
    disk=""
    
    choose_drive() {
    
      printf ${WHITE}"This is your curent configuration:\n${MAGENTA}$drives\n"

      option_prompt "${MAGENTA}Which drive do you want to install Gentoo on?"
      read drive
      if [[ $drive -gt $drivenr || $drive -lt 1 ]]; then
        printf "${YELLOW}\"$drive\"${RED} is not a valid option!${WHITE}\n"
        choose_drive
      else
        printf ${CYAN}"You selected drive ${YELLOW}\"$drive\"\n"
        disk="$(lsblk -o NAME,TYPE | grep -m$drive disk | awk {' print $1 '} | sed -n "$drive{p;q}")" 
      fi

      select_partition_route() {

        option_prompt "What do you want to do from here?" "Go with predefined partitions" "Create your own partitions" "Back" "Quit"
        read partitions
  
        case $partitions in
          1)

            lastdrive_size=$(( $(( $(lsblk -b | grep -m1 $disk | awk {' print $4 '}) - (256 * 1048576) - (4 * 1024 * 1048576) )) / 1073741824 ))

            printf "The predefined partitions are:\n"
            printf "NAME        SIZE            TYPE                MOUNTPOINTS\n"
            printf "${disk}         $(lsblk | grep -m1 $disk | awk {' print $4 '})          disk\n"
            printf "${disk}1        256M            EFI System          /boot\n"
            printf "${disk}2        4G              Linux Swap          [SWAP]\n"
            printf "${disk}3        ${lastdrive_size}G            Linux filesystem    /\n"
            
            option_prompt "Are you sure you want to continue?\n${RED}WARNING${YELLOW}THIS WILL ERAZE ALL THE DATA ON YOUR DISK!!${MAGENTA}" "Continue with this partition scheme" "Make your own partitions" "Back" "Quit"
            read partitions_confirmation
            
            case $partitions_confirmation in 

              1)

                #disk
                wipefs -a /dev/sda
                #disk1-3
                (echo o; echo n; echo p; echo ; echo ; echo +256M; echo n; echo p; echo ; echo ; echo +4G; echo t; echo 82; echo n; echo p; echo ; echo; echo; echo w;) | fdisk /dev/$disk

                #filesystems
                mkfs.vfat -F 32 /dev/${disk}1
                mkfs.ext4 /dev/${disk}3
                mkswap /dev/${disk}2
                swapon /dev/${disk}2

                ;;

            esac

            ;;

        esac
      }

      select_partition_route

      #select_partition_route() {

      #  option_prompt "${MAGENTA}What do you want to do from here?" "Go with predefined partitions" "Create your own partitions" "Back" "Quit"
      #  read partitions
      
      #  case $partitions in
      #    1)
      #      lastdrive_size=$(( $(( $(lsblk -b | grep -m1 $disk | awk {' print $4 '}) - (256 * 1048576) - (4 * 1024 * 1048576) )) / 1073741824 ))

      #        printf "The predefined partitions are:\n"
      #        printf "NAME        SIZE            TYPE                MOUNTPOINTS\n"
      #        printf "${disk}         $(lsblk | grep -m1 $disk | awk {' print $4 '})          disk\n"
      #        printf "${disk}1        256M            EFI System          /boot\n"
      #        printf "${disk}2        4G              Linux Swap          [SWAP]\n"
      #        printf "${disk}3        ${lastdrive_size}G            Linux filesystem    /\n"

      #        yn_prompt "Are you ok with this partitions?"
      #        solve_ynprompt "echo test" select_partition_route

      #        ;;

      #    2)
      #      echo to do
      #      ;;

      #    3) 
      #      choose_drive
      #      ;;

      #    4) 
      #      printf "Goodbye!\n"
      #      ;;

      #    *)
      #      select_partition_route
      #      printf "${YELLOW}\"$1\"${RED} is not a valid option!${WHITE}\n"
      #      ;;
      #  esac

      #}

      #select_partition_route

    }

    choose_drive

  }

  select_drive

elif [ "$1" = 3 ]; then # efi mode
  echo efi_test

else
  check_efi

fi
