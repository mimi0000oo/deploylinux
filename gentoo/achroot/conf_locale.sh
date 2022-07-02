#!/bin/bash

conf_locale() {

  echo en_US ISO-8859-1 >> /etc/locale.gen
  echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
  locale-gen
  eselect locale set 6
  env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

}
