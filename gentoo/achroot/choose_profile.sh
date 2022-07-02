#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/yn_prompt.sh
# include end

choose_profile() {

  eselect profile list
  profile_nr=$(eselect profile list | grep -c default)
  
  profile_option(){

    printf "${MAGENTA}What profile do you want (1 - $profile_nr)?\n> ${WHITE}"
    read prof_opt
    if [ $prof_opt -gt $profile_nr ]; then
      printf "${YELLOW}\"$prof_opt\"${RED} is not a valid option!${WHITE}\n"
    elif [ $prof_opt -lt 1 ]; then
      printf "${YELLOW}\"$prof_opt\"${RED} is not a valid option!${WHITE}\n"
    else
      continue_case(){

        yn_prompt "Are you sure you want to continue with profile $prof_opt?"
        read sure
        case "$sure" in
          [yY]*)
            printf ${GREEN}"OK!"
            eselect profile set $prof_opt
            ;;
          [nN]*)
            continue_case
            ;;
          *)
            printf "${YELLOW}\"$sure\"${RED} is not a valid option!${WHITE}\n"
            ;;
        esac

      }

      continue_case

    fi
    
  }

  profile_option

}

