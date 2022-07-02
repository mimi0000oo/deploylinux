#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/yn_prompt.sh
# include end

timezone() {

  emerge --config sys-libs/timezone-data

  ls /usr/share/zoneinfo
  printf ${MAGENTA}"What is your timezone? (Europe/Brussels)\n> ${WHITE}"
  read timezone
  
  check_timezone() {

    yn_prompt "Is $timezone correct?"
    read correct
    case "$correct" in
      [yY]*)
        printf "Let's keep going!"

        if [ $(file /sbin/init | grep systemd) ]; then
          ln -sf ../usr/share/zoneinfo/$timezone /etc/localtime
        else
          echo $timezone > /etc/timezone
          emerge --config sys-libs/timezone-data

        fi

        ;;
      [nN]*)
        timezone 
        ;;
      *)
        printf "${YELLOW}\"$correct\"${RED} is not a valid option!${WHITE}\n"
        check_timezone
        ;;
    esac

  }

  check_timezone
  

}

