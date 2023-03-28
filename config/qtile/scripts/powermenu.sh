#!/bin/sh

confirm_action() {
  confirm=$(echo -e "Sim\nNao" | rofi -p "Tem certeza?" -dmenu -l 2)
  case $confirm in
    'Sim') echo 0 ;;
    *) echo 1 ;;
  esac
}

poweroff=" Desligar"
reboot=" Reiniciar"
logout="󰗼 Sair"
lock=" Bloquear"

options="$poweroff\n$reboot\n$logout\n$lock"

option=$(echo -e "$options" | rofi -p "Powermenu" -dmenu -l 4)

case $option in
  $poweroff)
    if [[ $(confirm_action) -eq 0 ]];then
      poweroff
    else
      return
    fi
    ;;
  $reboot)
    if [[ $(confirm_action) -eq 0 ]];then
      reboot
    else
      return
    fi 
    ;;
  $logout)
    if [[ $(confirm_action) -eq 0 ]];then
      loginctl terminate-session $XDG_SESSION_ID
    else
      return
    fi
    ;;
  $lock)
    betterlockscreen -l
    ;;
esac
