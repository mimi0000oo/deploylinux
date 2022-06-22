#!/bin/bash

# include files
source ./other/colors.sh
source ./other/distro.sh
# include end

solve_ynprompt() {
  read option

  case $option in
    [yY]*) 
      if [ $distro == "archlinux" ]; then printf ${BLUE}$($1); else printf ${MAGENTA}$($1); fi; 
      ;;

    [nN]*)
      if [ $distro == "archlinux" ]; then printf ${BLUE}$($2); else printf ${MAGENTA}$($2); fi; 
      ;;

    *)
      printf "${YELLOW}\"$option\"${RED} is not a valid option!${WHITE}\n"
      solve_ynprompt "$1" "$2"
      ;;
  
  esac

}
