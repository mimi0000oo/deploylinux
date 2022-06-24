#!/bin/bash

# include files
source ./prompts/option_prompt.sh
source ./prompts/solve_optprompt.sh
source ./prompts/yn_prompt.sh
source ./prompts/solve_ynprompt.sh
source ./other/colors.sh
check_efi() { ./other/check_efi.sh; }
# include end

mount_root() {
  
  mkdir --parents /mnt/gentoo
  mount /dev/$1$2 /mnt/gentoo

}



select_drive() {

  mode=$1
  
  drives="$(lsblk -o MODEL,NAME,SIZE,TYPE,MOUNTPOINTS,HOTPLUG | grep disk)"
  drivenr="$(lsblk -o MODEL,NAME,SIZE,TYPE,MOUNTPOINTS,HOTPLUG | grep -c disk)"
  disk=""
  root_nr=3
  
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

        if [ $mode -eq 0 ]; then

          printf "The predefined partitions are:\n"
          printf "NAME        SIZE            TYPE                MOUNTPOINTS\n"
          printf "${disk}         $(lsblk | grep -m1 $disk | awk {' print $4 '})             disk\n"
          printf "${disk}1        256M            Linux               /boot\n"
          printf "${disk}2        4G                 Linux Swap          [SWAP]\n"
          printf "${disk}3        ${lastdrive_size}G          Linux               /\n"

        else

          printf "The predefined partitions are:\n"
          printf "NAME        SIZE            TYPE                MOUNTPOINTS\n"
          printf "${disk}         $(lsblk | grep -m1 $disk | awk {' print $4 '})             disk\n"
          printf "${disk}1        256M            EFI System          /boot\n"
          printf "${disk}2        4G                 Linux Swap          [SWAP]\n"
          printf "${disk}3        ${lastdrive_size}G          Linux filesystem    /\n"

        fi

      
        option_prompt "Are you sure you want to continue?\n${RED}WARNING! ${YELLOW}THIS WILL WIPE ALL THE DATA ON YOUR DISK!!${MAGENTA}" "Continue with this partition scheme" "Make your own partitions" "Back" "Quit"

      }

      partition_case() {
      
        case $1 in

          1)

            predefined_partition_scheme() {
        
              #disk
              wipefs -a /dev/${disk}
              #disk1-3

              if [ $mode -eq 0 ]; then

                (echo o; echo n; echo p; echo ; echo ; echo +256M; echo n; echo p; echo ; echo ; echo +4G; echo t; echo 2; echo 82; echo n; echo p; echo ; echo; echo; echo w;) | fdisk /dev/$disk

              else 

                (echo g; echo n; echo ; echo ; echo +256M; echo n; echo ; echo ; echo +4G; echo t; echo 2; echo 19; echo n; echo ; echo; echo; echo w;) | fdisk /dev/$disk

              fi

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

                    printf "${MAGENTA}This are your partitions now!\n${WHITE}$(lsblk | grep $disk)\n"
                    option_prompt "Is this ok?" "Yes" "No, back to fdisk" "Go to the predefined partitions" "Quit"
                    read fdisk_exit

                    case $fdisk_exit in 

                      1)

                        select_partitions_number() {

                          printf $MAGENTA"What is your boot partition nr?\n> ${WHITE}"
                          read boot_partition

                          if [ $boot_partition -lt 1 ]; then printf "${YELLOW}\"$boot_partition\"${RED} is not a valid option!${MAGENTA}\n" select_partitions_number; fi

                          printf $MAGENTA"What is your swap partition nr? (0 for none)\n> ${WHITE}"
                          read swap_partition
                        
                          if [ $swap_partition -lt 0 ]; then printf "${YELLOW}\"$swap_partition\"${RED} is not a valid option!${MAGENTA}\n" select_partitions_number; fi

                          printf $MAGENTA"What is your root partition nr?\n> ${WHITE}"
                          read root_partition
                        
                          if [ $root_partition -lt 1 ]; then printf "${YELLOW}\"$root_partition\"${RED} is not a valid option!${MAGENTA}\n" select_partitions_number; fi
  
                          if [ $swap_partition -eq 0 ]; then 
                            printf "${WHITE}So your setup is:\n${disk} - disk\n${disk}${boot_partition} - boot\n${disk}${root_partition} - root\n"
                          else
                            printf "${WHITE}So your setup is:\n${disk} - disk\n${disk}${boot_partition} - boot\n${disk}${swap_partition} - swap\n${disk}${root_partition} - root\n"
                          fi
                        
                          final_custom_check_case() {

                            option_prompt "Is that ok?\n${RED}WARNING! ${YELLOW}THIS WILL MARK YOUR PARTITIONS WITH THE SPECIFIC TYPE!!${MAGENTA}" "Yes" "No, wrong numbers" "No, go back to fdisk"
                            read final_custom_check

                            case $final_custom_check in 

                              1)
                                printf ${GREEN}"Writing partitions types!"
                                mkfs.vfat -F 32 /dev/${disk}${boot_partition}
                                mkfs.ext4 /dev/${disk}${root_partition}
                                if [ $swap_partition != 0 ]; then mkswap /dev/${disk}${swap_partition}; swapon /dev/${disk}${swap_partition}; fi 
                                root_nr=$root_partition
                                  
                                ;;

                              2)
                                select_partitions_number
                                ;;

                              3)
                                enter_custom_configuration
                                ;;

                              *)
                                printf "${YELLOW}\"$final_custom_check\"${RED} is not a valid option!${WHITE}\n"
                                final_custom_check_case
                                ;;

                            esac

                          }

                          final_custom_check_case

                        }

                        select_partitions_number

                        ;;

                      2)
                        enter_custom_configuration
                        ;;

                      3)
                        partition_case 1
                        ;;

                      4)
                        echo Goodbye!
                        ;;

                      *)
                        printf "${YELLOW}\"$predefined_confirmation\"${RED} is not a valid option!${MAGENTA}\n"
                        enter_custom_configuration
                        ;;

                    esac


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

  mount_root $disk $root_nr

}




if [ "$1" = 2 ]; then # bios mode

  select_drive 0

elif [ "$1" = 3 ]; then # efi mode

  select_drive 1

else
  check_efi

fi
