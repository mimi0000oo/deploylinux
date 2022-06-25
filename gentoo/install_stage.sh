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

                  printf ${MAGENTA}"Please enter your current unix time\n> ${WHITE}"
                  read unixtime_date
                  case "$unixtime_date" in
                    [1234567890]*) 
                  
                      ok_time_update () {

                        date $unixtime_date
                        option_prompt "Time is: $(date)" "Good!" "Update again" 
                        read ok_date

                        case "$ok_date" in
                          1) 
                            printf "Good!"
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
    
    option_prompt "What stage3 do you want?" "openrc (recommanded)" "desktop profile | openrc" "systemd" "desktop profile | systemd"
    read stage3_choice
    solve_optprompt $stage3_choice "wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/current-stage3-amd64-openrc/stage3-amd64-openrc-*.tar.gz"
    #solve_optprompt $stage3_choice "wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20220619T170540Z/stage3-amd64-openrc-20220619T170540Z.tar.xz" 

    tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

}
