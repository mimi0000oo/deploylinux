#!/bin/bash

# include files
source ./other/colors.sh
source ./other/distro.sh
source ./prompts/option_prompt.sh
arch_start_configuration() { ./arch/./start_configuration.sh; }
gentoo_start_configuration() { ./gentoo/./start_configuration.sh; }
arch_import_configuration() { ./arch/./import_configuration.sh; }
gentoo_import_configuration() { ./gentoo/./import_configuration.sh; }
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

if [ $distro == "archlinux" ]; then 
echo ╔╗───╔╗╔╗──────────╔╗─────────╔═╦╗───────╔═╗╔╗╔╗───╔╗──╔═╦╗
echo ║╚╦═╗║╚╣╚╦═╗╔═╗╔╦╦═╣╚╗╔═╦═╦═╦╦╣═╬╬═╦═╦╗╔═╣═╣║╚╣╚╦═╗╠╬═╦╣═╣╚╦═╗╔╗╔╗╔═╦╦╗
echo ║╔╣╬║║╔╣║║╩╣║╬╚╣╔╣═╣║║╚╗║╔╣╩╣╔╬═║║╬║║║║║╬║╔╝║╔╣║║╩╣║║║║╠═║╔╣╬╚╣╚╣╚╣╩╣╔╝
echo ╚═╩═╝╚═╩╩╩═╝╚══╩╝╚═╩╩╝─╚═╝╚═╩╝╚═╩╩═╩╩═╝╚═╩╝─╚═╩╩╩═╝╚╩╩═╩═╩═╩══╩═╩═╩═╩╝
else 
echo ╔╗───╔╗╔╗──────────╔╗─────────────╔═╦╗───────╔═╗╔╗╔╗───╔╗──╔═╦╗
echo ║╚╦═╗║╚╣╚╦═╗╔═╦═╦═╦╣╚╦═╦═╗╔═╦═╦═╦╦╣═╬╬═╦═╦╗╔═╣═╣║╚╣╚╦═╗╠╬═╦╣═╣╚╦═╗╔╗╔╗╔═╦╦╗
echo ║╔╣╬║║╔╣║║╩╣║╬║╩╣║║║╔╣╬║╬║╚╗║╔╣╩╣╔╬═║║╬║║║║║╬║╔╝║╔╣║║╩╣║║║║╠═║╔╣╬╚╣╚╣╚╣╩╣╔╝
echo ╚═╩═╝╚═╩╩╩═╝╠╗╠═╩╩═╩═╩═╩═╝─╚═╝╚═╩╝╚═╩╩═╩╩═╝╚═╩╝─╚═╩╩╩═╝╚╩╩═╩═╩═╩══╩═╩═╩═╩╝
echo ────────────╚═╝
fi
# end of the welcome

setup_prompt() {

  option_prompt "You have a few options to choose from:" "Start the configuration" "Import a configuration file" "Quit" "Quit and delete the script"
  read option
  case $option in 
    1)
      if [ $distro == "archlinux" ]; then arch_start_configuration; else gentoo_start_configuration; fi; 
      ;;
    2)
      if [ $distro == "archlinux" ]; then arch_import_configuration; else gentoo_import_configuration; fi; 
      ;;
    3)
      printf "Goodbye!\n" 
      ;;
    4)
      rm ../testing.zip && rm -r ../deploylinux-testing
      printf "Goodbye!\n" 
      ;;
    *)
      printf "${YELLOW}\"$option\"${RED} is not a valid option!${WHITE}\n"
      ;;
  esac

}
setup_prompt
