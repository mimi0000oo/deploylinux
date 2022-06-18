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

if [ $distro = "archlinux" ]; then printf $BLUE; else printf $MAGENTA; fi; 
clear
# welcome message
echo "  "░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗ 
echo "  "░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝
echo "  "░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░
echo "  "░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░
echo "  "░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗
echo "  "░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝
echo ""

if [ $distro = "archlinux" ]; then 
echo " _         _   _                      _                     _                 __   _   _          _         _        _ _         "
echo "| |_ ___  | |_| |_  ___   __ _ _ _ __| |_   __ _____ _ _ __(_)___ _ _    ___ / _| | |_| |_  ___  (_)_ _  __| |_ __ _| | |___ _ _ "
echo "|  _/ _ \ |  _| ' \/ -_) / _\` | '_/ _| ' \  \ V / -_) '_(_-< / _ \ ' \  / _ \  _| |  _| ' \/ -_) | | ' \(_-<  _/ _\` | | / -_) '_|"
echo " \__\___/  \__|_||_\___| \__,_|_| \__|_||_|  \_/\___|_| /__/_\___/_||_| \___/_|    \__|_||_\___| |_|_||_/__/\__\__,_|_|_\___|_|  "
else 
echo " _         _   _                       _                             _                 __   _   _          _         _        _ _         "
echo "| |_ ___  | |_| |_  ___   __ _ ___ _ _| |_ ___  ___  __ _____ _ _ __(_)___ _ _    ___ / _| | |_| |_  ___  (_)_ _  __| |_ __ _| | |___ _ _ "
echo "|  _/ _ \ |  _| ' \/ -_) / _\` / -_) ' \  _/ _ \/ _ \ \ V / -_) '_(_-< / _ \ ' \  / _ \  _| |  _| ' \/ -_) | | ' \(_-<  _/ _\` | | / -_) '_|"
echo " \__\___/  \__|_||_\___| \__, \___|_||_\__\___/\___/  \_/\___|_| /__/_\___/_||_| \___/_|    \__|_||_\___| |_|_||_/__/\__\__,_|_|_\___|_|  "
echo "                         |___/                                                                                                            "
fi
# end of the welcome

setup_prompt() {

  option_prompt "You have a few options to choose from:" "Start the configuration" "Import a configuration file" "Quit" "Quit and delete the script"
  read option
  case $option in 
    1)
      if [ $distro = "archlinux" ]; then arch_start_configuration; else gentoo_start_configuration; fi; 
      ;;
    2)
      if [ $distro = "archlinux" ]; then arch_import_configuration; else gentoo_import_configuration; fi; 
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
      setup_prompt
      ;;
  esac

}
setup_prompt
