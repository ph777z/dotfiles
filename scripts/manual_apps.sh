#!/bin/bash

function manual_apps() {
  pacman -Qi $2 &>/dev/null
  
  if [ ! $? -eq 0 ];then
    curl $1 > $2.pkg.tar.zst
    sudo pacman -U --noconfirm $2.pkg.tar.zst
    rm $2.pkg.tar.zst
  fi
}

manual_apps https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst megasync