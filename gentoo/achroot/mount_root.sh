#!/bin/bash

mount_root() {

  mountpoint="$(cat ./gentoo/bchroot_data | sed -n '1p;q')"

  mount $mountpoint /boot
  sleep 10

}
