#!/bin/bash

# include files
source ./prompts/option_prompt.sh
source ./prompts/solve_optprompt.sh
# include end

kernel() {

  emerge sys-kernel/linux-firmware

 option_prompt "What type of kernel configuration do you want?" "Manual configuration" "Genkernel" "Distribution kernel" 
 
 manual_kernel() {

   emerge sys-kernel/gentoo-sources
   kernelvesion="$(eselect kernel list | grep "\[a\]" | awk {' print $2 '} | sed s/linux-//)"
   
   eselect kernel set 1
   emerge sys-apps/pciutils
   printf "Entering the kernel!"
   sleep 2
   (cd /usr/src/linux/ && make menuconfig)
   (cd /usr/src/linux/ && make && make modules_install)
   (cd /usr/src/linux/ && make install)

   emerge sys-kernel/dracut
   dracut --kver=$kernelvesion
   

 }
 
 genkernel() {

 }
 dis_kernel() {

 }

 read kernel_option
 solve_optprompt $kernel_option manual_kernel genkernel dis_kernel

}

