#!/bin/bash

# include files
source ./other/colors.sh
source ./other/distro.sh
source ./other/create_prompt.sh
start_configuration() { ./arch/./start_configuration.sh; }
import_configuration() { ./gentoo/./import_configuration.sh; }
# include end

if [ $distro == "archlinux" ]; then printf $BLUE; else printf $MAGENTA; fi; 
clear
# welcome message
echo "  "░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗ 
echo "  "░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝
echo "  "░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░
echo "  "░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░
echo "  "░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗
echo "  "░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝
echo ""
echo ╔╗───╔╗╔╗──────────╔╗─────────╔═╦╗───────╔═╗╔╗╔╗───╔╗──╔═╦╗
echo ║╚╦═╗║╚╣╚╦═╗╔═╗╔╦╦═╣╚╗╔═╦═╦═╦╦╣═╬╬═╦═╦╗╔═╣═╣║╚╣╚╦═╗╠╬═╦╣═╣╚╦═╗╔╗╔╗╔═╦╦╗
echo ║╔╣╬║║╔╣║║╩╣║╬╚╣╔╣═╣║║╚╗║╔╣╩╣╔╬═║║╬║║║║║╬║╔╝║╔╣║║╩╣║║║║╠═║╔╣╬╚╣╚╣╚╣╩╣╔╝
echo ╚═╩═╝╚═╩╩╩═╝╚══╩╝╚═╩╩╝─╚═╝╚═╩╝╚═╩╩═╩╩═╝╚═╩╝─╚═╩╩╩═╝╚╩╩═╩═╩═╩══╩═╩═╩═╩╝
# end of the welcome

create_prompt "You have a few options to choose from:" "Start the configuration" "Import a configuration file" "Quit" "Quit and delete the script"
read welcomeoption
case $welcomeoption in 
  1)
    if [ $distro == "archlinux" ]; then ./arch/./start_configuration.sh; else ./gentoo/./start_configuration.sh; fi; 
    ;;
  2)
    if [ $distro == "archlinux" ]; then ./arch/./import_configuration.sh; else ./gentoo/./import_configuration.sh; fi; 
    ;;
  3)
    printf "Goodbye!\n" 
    ;;
  4)
    rm ../testing.zip && rm -r ../deploylinux-testing
    printf "Goodbye!\n" 
    ;;
  *)
    printf "${YELLOW}\"$welcomeoption\"${RED} is not a valid option!${WHITE}\n"
    ;;
esac
