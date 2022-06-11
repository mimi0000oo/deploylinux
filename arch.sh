#!/bin/bash

# colors
RED="\e[38;5;9m"
GREEN="\e[38;5;10m"
YELLOW="\e[38;5;11m"
BLUE="\e[38;5;12m"
MAGENTA="\e[38;5;13m"
CYAN="\e[38;5;14m"
WHITE="\e[38;5;15m"
# colors end
clear

printf "$BLUE" 
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

create_prompt() {
  arch/./create_prompt.sh "$@"
}

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
    clear
    printf "Goodbye!\n" 
    ;;
  4)
    rm ../testing.zip && rm -r ../deploylinux-testing
    ;;
  *)
    printf "${YELLOW}\"$welcomeoption\"${RED} is not a valid option!${WHITE}\n"
    ;;
esac
