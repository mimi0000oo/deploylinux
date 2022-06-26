#!/bin/bash

#include files
source ./other/colors.sh
create_partitions() { ./gentoo/create_partitions.sh; }
source ./gentoo/install_stage.sh
source ./gentoo/conf_compile_opt.sh
#include end

create_partitions
install_stage
conf_compile_opt
