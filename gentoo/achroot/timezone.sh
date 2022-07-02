#!/bin/bash

# include files
source ./other/colors.sh
source ./prompts/yn_prompt.sh
# include end

timezone() {

  emerge --config sys-libs/timezone-data

}
