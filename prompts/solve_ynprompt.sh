#!/bin/bash

# include files
source ./other/colors.sh
# include end

solve_ynprompt() {
  read option

  case $option in
    [yY]*) 
      if [ $distro == "archlinux" ]; then echo ${BLUE}$($1); else echo ${MAGENTA}$($1); fi; 
      ;;

    [nN]*)
      if [ $distro == "archlinux" ]; then echo ${BLUE}$($2); else echo ${MAGENTA}$($2); fi; 
      ;;

    *)
      printf "${YELLOW}\"$option\"${RED} is not a valid option!${WHITE}\n"
      ;;
  
  esac

}
