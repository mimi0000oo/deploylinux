#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/option_prompt.sh
#include end
 
conf_compile_opt() {

  clear
  printf ${MAGENTA}"Let's make some compile options!\n"

  compile_opt() {

    option_prompt "What do you want to do?" "Go with the default compile options" "Make your own compile options" "Don't modify anything"
    read comp_opt

    case "$comp_opt" in
      1)
        jobs=""
        cpujobs=$(( $(lscpu | grep "CPU family:" | awk {' print $2 '}) * $(lscpu | grep "Thread(s) per core:" | awk {' print $2 '}) ))
        ramjobs=$(free -th | grep Mem: | awk {' print $2 '})

        cat /mnt/gentoo/etc/portage/make.conf | sed "s/-O2 -pipe/-march=native -O2 -pipe/" | sed "s/FFLAGS=\"\${COMMON_FLAGS}\"/FFLAGS=\"\${COMMON_FLAGS}\"\nMAKEOPTS=\"-j$jobs\""
        ;;
      2|3) echo 2 or 3
      ;;
      *)
         printf "${YELLOW}\"$comp_opt\"${RED} is not a valid option!${WHITE}\n"
         compile_opt
      ;;
    esac

  }

  compile_opt

}
conf_compile_opt
