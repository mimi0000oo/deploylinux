#!/bin/sh

MAGENTA="\e[38;5;13m"
WHITE="\e[0m"

printf "$1\n"
args=("$@")

for (( i=1; i<=$(($# - 1)); i++ )); do
  printf "$i)$WHITE ${args[${i}]}\n$MAGENTA"
done
