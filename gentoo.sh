#!/bin/bash

# colors
RED="\e[38;5;9m"
GREEN="\e[38;5;10m"
YELLOW="\e[38;5;11m"
BLUE="\e[38;5;12m"
MAGENTA="\e[38;5;13m"
CYAN="\e[38;5;14m"
WHITE="\e[0m"
# colors end
# include files
create_prompt() { gentoo/./create_prompt.sh "$@" }
start_configuration() { gentoo/./start_configuration.sh }
import_configuration() { gentoo/./import_configuration.sh }
#include end

printf $MAGENTA
clear
# welcome message
echo "    "░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗ 
echo "    "░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝
echo "    "░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░
echo "    "░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░
echo "    "░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗
echo "    "░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝
echo ""
echo ╔╗───╔╗╔╗──────────╔╗─────────────╔═╦╗───────╔═╗╔╗╔╗───╔╗──╔═╦╗
echo ║╚╦═╗║╚╣╚╦═╗╔═╦═╦═╦╣╚╦═╦═╗╔═╦═╦═╦╦╣═╬╬═╦═╦╗╔═╣═╣║╚╣╚╦═╗╠╬═╦╣═╣╚╦═╗╔╗╔╗╔═╦╦╗
echo ║╔╣╬║║╔╣║║╩╣║╬║╩╣║║║╔╣╬║╬║╚╗║╔╣╩╣╔╬═║║╬║║║║║╬║╔╝║╔╣║║╩╣║║║║╠═║╔╣╬╚╣╚╣╚╣╩╣╔╝
echo ╚═╩═╝╚═╩╩╩═╝╠╗╠═╩╩═╩═╩═╩═╝─╚═╝╚═╩╝╚═╩╩═╩╩═╝╚═╩╝─╚═╩╩╩═╝╚╩╩═╩═╩═╩══╩═╩═╩═╩╝
echo ────────────╚═╝
# end of the welcome

create_prompt "You have a few options to choose from:" "Start the configuration" "Import a configuration file" "Quit" "Quit and delete the script"
read welcomeoption
case $welcomeoption in 
  1)
    start_configuration
    ;;
  2)
    import_configuration
    ;;
  3)
    printf "Goodbye!" 
    ;;
  4)
    rm ../testing.zip && rm ../deploylinux-testing
    ;;
  *)
    printf $RED "$YELLOW\"$welcomeoption\"$RED is not a valid option"
    ;;
esac
