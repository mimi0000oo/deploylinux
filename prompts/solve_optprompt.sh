#!/bin/bash

# include files
source ../other/colors.sh
source ../other/distro.sh
# include end

solve_optprompt() {
  
  case $1 in
    ''|*[!0-9]* ) 
      printf "${YELLOW}\"$1\"${RED} is not a valid option!${WHITE}\n"
      ;;

    *) 
      
      if [ $1 -gt $(($# - 1)) ]; then
      printf "${YELLOW}\"$1\"${RED} is not a valid option!${WHITE}\n"

    elif [ $1 -lt 1 ]; then
      printf "${YELLOW}\"$1\"${RED} is not a valid option!${WHITE}\n"

    else 
      args=("$@")
      if [ $distro == "archlinux" ]; then echo ${BLUE}$(${args[${moption}]}); else ${MAGENTA}$(${args[${moption}]}); fi; 
      
    fi

      ;;
  esac

}
