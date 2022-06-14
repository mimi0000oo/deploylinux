#!/bin/bash

#include files
source ./other/colors.sh
create_partitions() { ./gentoo/create_partitions.sh; }
#include end

create_partitions
