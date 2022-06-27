#!/bin/bash

mount_root() {

  disk="$(cat ./bchroot_data)"

  mount /dev/$disk /boot

}
