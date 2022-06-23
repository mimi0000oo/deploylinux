#!/bin/bash

# include files
source ./prompts/option_prompt.sh
source ./prompts/solve_optprompt.sh
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
    
      printf ${WHITE}"This is your curent disk configuration:\n${MAGENTA}$drives\n"

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

        
        predefined_partitions() {
          lastdrive_size=$(( $(( $(lsblk -b | grep -m1 $disk | awk {' print $4 '}) - (256 * 1048576) - (4 * 1024 * 1048576) )) / 1073741824 ))

          printf "The predefined partitions are:\n"
          printf "NAME        SIZE            TYPE                MOUNTPOINTS\n"
          printf "${disk}         $(lsblk | grep -m1 $disk | awk {' print $4 '})             disk\n"
          printf "${disk}1        256M            EFI System          /boot\n"
          printf "${disk}2        4G                 Linux Swap          [SWAP]\n"
          printf "${disk}3        ${lastdrive_size}G          Linux filesystem    /\n"
        
          option_prompt "Are you sure you want to continue?\n${RED}WARNING! ${YELLOW}THIS WILL WIPE ALL THE DATA ON YOUR DISK!!${MAGENTA}" "Continue with this partition scheme" "Make your own partitions" "Back" "Quit"

        }

        partition_case() {
        
          case $1 in

            1)

              predefined_partition_scheme() {
          
                #disk
                wipefs -a /dev/${disk}
                #disk1-3
                (echo o; echo n; echo p; echo ; echo ; echo +256M; echo n; echo p; echo ; echo ; echo +4G; echo t; echo 2; echo 82; echo n; echo p; echo ; echo; echo; echo w;) | fdisk /dev/$disk

                #filesystems
                mkfs.vfat -F 32 /dev/${disk}1
                mkfs.ext4 /dev/${disk}3
                mkswap /dev/${disk}2
                swapon /dev/${disk}2

              }
            
              predefined_confirmation_case() {
                
                predefined_partitions
                read predefined_confirmation


                case $predefined_confirmation in 
              
                  1)
                    predefined_partition_scheme
                    ;;

                  2)
                    partition_case 2
                    ;;

                  3)
                    select_partition_route
                    ;;

                  4)
                    echo Goodbye!
                    ;;

                  *)
                    printf "${YELLOW}\"$predefined_confirmation\"${RED} is not a valid option!${MAGENTA}\n"
                    predefined_confirmation_case
                    ;;

                esac        

              }

              predefined_confirmation_case

              ;;

            2)
              custom_confirmation_case() {

                printf "${MAGENTA}This are your partitions at the moment:\n${WHITE}$(lsblk)\n"
                yn_prompt "I will drop you in the fdisk setup! Is that ok?"
                read custom_confirmation
  
                case $custom_confirmation in 
                  
                  [yY]*) 

                    enter_custom_configuration() {
                      fdisk /dev/${disk}

                      printf "${MAGENTA}This are your partitions now!\n$(lsblk)\n"
                      option_prompt "Is this ok?" "Yes" "No" "Back to fdisk" "Go to the predefined partitions" "Quit"

                    }

                    enter_custom_configuration

                    ;;

                  [nN]*)
                    printf "Going back!\n"
                    select_partition_route
                    ;;

                  *)
                    printf "${YELLOW}\"$custom_confirmation\"${RED} is not a valid option!${WHITE}\n"
                    custom_confirmation_case
                    ;;

                  esac    
              }

              custom_confirmation_case 

              ;;

            3)
              choose_drive
              ;;

            4)
              printf "Goodbye!\n"
              ;;

            *)
              printf "${YELLOW}\"$partitions\"${RED} is not a valid option!${MAGENTA}\n"
              select_partition_route
              ;;

            esac

        }

        partition_case $partitions

      }
  
      select_partition_route

    }

    choose_drive

  }

  select_drive

elif [ "$1" = 3 ]; then # efi mode
  echo efi_test

else
  check_efi

fi
