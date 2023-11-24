#!/bin/bash

confirm_action() {
  confirm=$(echo -e "Sim\nNao" | rofi -dmenu -theme dmenu -p "Tem certeza?" -l 2 -i)
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


option=$(echo -e "$options" | rofi -dmenu -theme dmenu -p "Powermenu:" -l 4 -i)

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
    slock
    ;;
esac