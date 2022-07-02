#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/yn_prompt.sh
# include end

choose_profile() {

  eselect profile list
  total_profiles_nr=$(eselect profile list | grep -c linux)

  profile_option() {
    printf "${MAGENTA}What profile do you want (1 - $total_profiles_nr)?\n> ${WHITE}"
    read prof_opt
    case "$prof_opt" in
      [1234567890]*) 
        if [ $prof_opt -gt $total_profiles_nr ]; then
          printf "${YELLOW}\"$prof_opt\"${RED} is not a valid option!${WHITE}\n"
          choose_profile
        elif [ $prof_opt -lt 1 ]; then
          printf "${YELLOW}\"$prof_opt\"${RED} is not a valid option!${WHITE}\n"
          choose_profile
        else

          continue_case() {

            selected_prof_opt=$(eselect profile list | grep "\[$prof_opt\]")
            yn_prompt "Are you sure you want to continue with profile $prof_opt ($selected_prof_opt)?"
            read sure

            case "$sure" in
              [yY]*)
                printf ${GREEN}"OK!"
                eselect profile set $prof_opt
                ;;
            
              [nN]*)
                choose_profile
                ;;
              
              *)
                printf "${YELLOW}\"$sure\"${RED} is not a valid option!${WHITE}\n"
                continue_case
                ;;
            esac   

          }

          continue_case

        fi

        ;;
      *) 
        printf "${YELLOW}\"$prof_opt\"${RED} is not a valid option!${WHITE}\n"
        choose_profile
        ;;
    esac
  
  }

  profile_option

}

