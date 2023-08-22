#!/bin/bash

FONT="JetBrains:size=10"
BLACK="#11111b"
WHITE="#a6adc8"

confirm_action() {
  confirm=$(echo -e "Sim\nNao" | dmenu \
    -p "Tem certeza?" \
    -fn $FONT \
    -nb $BLACK \
    -nf $WHITE \
    -sb $WHITE \
    -sf $BLACK)
  case $confirm in
    'Sim') echo 0 ;;
    *) echo 1 ;;
  esac
}

poweroff="Desligar"
reboot="Reiniciar"
logout="Sair"
lock="Bloquear"

options="$poweroff\n$reboot\n$logout\n$lock"


option=$(echo -e "$options" | dmenu -i \
    -fn $FONT \
    -nb $BLACK \
    -nf $WHITE \
    -sb $WHITE \
    -sf $BLACK)

case $option in
  $poweroff)
    if [[ $(confirm_action) -eq 0 ]];then
      poweroff
    fi
    ;;
  $reboot)
    if [[ $(confirm_action) -eq 0 ]];then
      reboot
    fi 
    ;;
  $logout)
    if [[ $(confirm_action) -eq 0 ]];then
      loginctl terminate-session $XDG_SESSION_ID
    fi
    ;;
  $lock)
    slock -m "Bem vindo e volta $USER <3"
    ;;
esac