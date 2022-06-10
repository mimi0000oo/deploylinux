#!/bin/sh

distro="$(dmesg | grep "Linux version" | awk {' print $6 '} | sed -e 's/^([a-z]*@//' | sed -e 's/)//')"

echo $distro
