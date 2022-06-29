#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/option_prompt.sh
source ./prompts/yn_prompt.sh
source ./prompts/solve_ynprompt.sh
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
        cpujobs=$(( $(lscpu | grep "CPU family:" | awk {' print $3 '}) * $(lscpu | grep "Thread(s) per core:" | awk {' print $4 '}) ))
        ramjobs=$(free -th | grep Mem: | awk {' print $2 '})

        jobsnr(){
          printf "How many MAKEOPTS jobs do you want? (jobs help you compile packages faster, 2G ram is recommanded for every job)\nCPU: $cpujobs threads\nRAM: $ramjobs\n${MAGENTA}> ${WHITE}"
          read jobss

          if [ $jobss -gt $cpujobs ]; then
            printf "${RED}You cannot have more jobs than cpu threads!\n${WHITE}"
            jobsnr
          else
            yn_prompt "Are you sure you want $jobss jobs?"
            solve_ynprompt "" jobsnr 
          fi

        }

        jobsnr

        cat /mnt/gentoo/etc/portage/make.conf | sed "s/-O2 -pipe/-march=native -O2 -pipe/" | sed "s/FFLAGS=\"\${COMMON_FLAGS}\"/FFLAGS=\"\${COMMON_FLAGS}\"\nMAKEOPTS=\"-j$jobs\"/" | echo > /mnt/gentoo/etc/portage/make.conf
        ;;
      2)
        makeownco(){
          nano /mnt/gentoo/etc/portage/make.conf

          mkonwcook_case() {
            printf "$(cat /mnt/gentoo/etc/portage/make.conf)"
            yn_prompt "Is this ok?"
            read mkonwcook
            case "$mkonwcook" in
              [yY]*)
                echo Ok! 
                ;;
              [nN]*)
                makeownco
                ;;
              *)
                printf "${YELLOW}\"$mkonwcook\"${RED} is not a valid option!${WHITE}\n"
                makeownco_case
                ;;
            esac
          }

          makeownco_case  

        }

        makeownco
        
        ;;

      3)

        third() {

          yn_prompt "Are you sure do you want to let everything as it is?"
          read leaveeverything
          case $leaveeverything in

            1)
              printf "OK, if you are sure!"
              ;;

            2)
             compile_opt
              ;;

            *)
              printf "${YELLOW}\"$leaveeverything\"${RED} is not a valid option!${WHITE}\n"
              third
              ;;

          esac    

        }

        third

        ;;

      *)
         printf "${YELLOW}\"$comp_opt\"${RED} is not a valid option!${WHITE}\n"
         compile_opt
      ;;
    esac

  }

  compile_opt

}
