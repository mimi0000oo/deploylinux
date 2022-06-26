#!/bin/bash

# include files
source ./prompts/yn_prompt.sh
source ./prompts/option_prompt.sh
source ./prompts/solve_ynprompt.sh
source ./prompts/solve_optprompt.sh
source ./other/colors.sh
# include end

install_stage() {

    acc_date() {
      
      yn_prompt "Is this date accurate?\n$(date)"
      read acc_date
      
      case $acc_date in
        [yY]*) 
          printf "Let's keep going than, there is no time to waste! (Literally)\n" 
          ;;

        [nN]*)

          not_accdate() {

            option_prompt "How do you want to update the time" "Manually" "Automatic (This will expoze your ip to ntp.org)" 
            read timeupdate

            case $timeupdate in
            
              1) 
              
                manually_time_update() {

                  printf ${MAGENTA}"Please enter your current time (MMDDhhmmYYYY)\n> ${WHITE}"
                  read unixtime_date
                  case "$date_time" in
                    [1234567890]*) 
                  
                      ok_time_update () {

                        date $date_time
                        option_prompt "Time is: $(date)" "Good!" "Update again" 
                        read ok_date

                        case "$ok_date" in
                          1) 
                            printf "Good!"
                            ;;

                          2)
                            manually_time_update
                            ;;
                      
                          *)
                            printf "${YELLOW}\"$ok_date\"${RED} is not a valid option!${WHITE}\n"
                            manually_time_update
                            ;;
                        esac
                          
                      }

                      ok_time_update

                    ;;
              
                    *)
                      printf "${YELLOW}\"$unixtime_date\"${RED} is not a valid option!${WHITE}\n"
                      manually_time_update
                      ;;
                  esac
                
                }
              
                manually_time_update

                ;;

              2) 
                emerge net-misc/ntp
                ntpd -q -g
                ;;

              *) 
                printf "${YELLOW}\"$timeupdate\"${RED} is not a valid option!${WHITE}\n"
                install_stage
                ;;

            esac
          
          }

          not_accdate

          ;;

        *)
          printf "${YELLOW}\"$acc_date\"${RED} is not a valid option!${WHITE}\n"
          install_stage
          ;;
      
      esac

    }

    acc_date 


    cd /mnt/gentoo
    
    stage3_opt=""
    stage3_setup() {

      option_prompt "What stage3 do you want?" "openrc (recommanded)" "desktop profile | openrc" "systemd" "desktop profile | systemd"
      predownlik="https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/"

      read stage3_choice
      case "$stage3_choice" in
        1) stage3opt="https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt"
        ;;
        2) stage3opt="https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/latest-stage3-amd64-desktop-openrc.txt"
        ;;
        3) stage3opt="https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/latest-stage3-amd64-system.txt"
        ;;
        4) stage3opt="https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/latest-stage3-amd64-desktop-system.txt"
        ;;
        *) stage3_setup 
        ;;
      esac

    }
    printf "${RED}before $stage3_opt"
    stage3_setup
    printf "${RED}after $stage3_opt"
    
    stage3_path=$(curl -L $stage3_opt | grep -v "^#" | cut -d " " -f1)

    solve_optprompt $stage3_choice "wget $stage3_path"
    #solve_optprompt $stage3_choice "wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20220619T170540Z/stage3-amd64-openrc-20220619T170540Z.tar.xz" 

    tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

}
