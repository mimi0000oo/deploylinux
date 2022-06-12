#!/bin/bash

# include files
source ./other/colors.sh
source ./other/distro.sh
# include end

option_prompt() {
  printf "$1\n"
  args=("$@")

  if [[ $distro == "archlinux" ]]; then
    for (( i=1; i<=$(($# - 1)); i++ )); do
      printf "${BLUE}$i)$WHITE ${args[${i}]}\n$BLUE"
    done
    printf "$BLUE> $WHITE"

  else 
    for (( i=1; i<=$(($# - 1)); i++ )); do
      printf "${MAGENTA}$i)$WHITE ${args[${i}]}\n$MAGENTA"
    done
    printf "$MAGENTA> $WHITE"
  
  fi

}
