#!/bin/sh

distro="$(dmesg | grep "Linux version" | awk {' print $8 '} | sed -e 's/(//')"

echo $(distro)
