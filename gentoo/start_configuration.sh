#!/bin/bash

#include files
source ./other/colors.sh
create_partitions() { ./gentoo/create_partitions.sh; }
source ./gentoo/install_stage.sh
#include end

create_partitions
install_stage