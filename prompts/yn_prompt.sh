#!/bin/bash

# include files
source ./other/colors.sh
source ./other/distro.sh
# include end

yn_prompt() {

  if [[ $distro == "archlinux" ]]; then
    printf "${BLUE}$1 (${GREEN}Yes${BLUE}/${RED}No${BLUE})\n"
    printf "$BLUE> $WHITE"

  else 
    printf "${MAGENTA}$1 (${GREEN}Yes${MAGENTA}/${RED}No${MAGENTA})\n"
    printf "$MAGENTA> $WHITE"
  
  fi

}
