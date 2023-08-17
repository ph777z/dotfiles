#!/bin/bash

enable_text="直 Habilitar Wi-Fi"
disable_text="睊 Desabilitar Wi-Fi"


connect_network() {
  if [[ ! $1 -eq 1 ]];then
    notify-send -t 925 "Buscando redes Wi-Fi..."
  fi
  wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")
  if [[ $wifi_list == "" ]];then
    connect_network 1
    return
  fi
  chosen_network=$(echo -e "$disable_text\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
  chosen_id=$(echo "${chosen_network:3}" | xargs)
  
  if [ "$chosen_network" = "" ]; then
	  exit
  elif [[ "$chosen_network" = $disable_text ]]; then
	  nmcli radio wifi off
  else
	  success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	  saved_connections=$(nmcli -g NAME connection)
	  if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		  nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Conexao estabelecida" "$success_message"
	  else
		  if [[ "$chosen_network" =~ "" ]]; then
			  wifi_password=$(rofi -dmenu -p "Senha: " )
		  fi
		  nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Conexao estabelecida" "$success_message"
	  fi
  fi
}

enable_network() {
  chosen_network=$(echo -e "$enable_text\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 0 -p "Wi-Fi SSID: " )
  if [[ "$chosen_network" = $enable_text ]];then
    nmcli radio wifi on
    connect_network
  else
    exit
  fi
}

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "habilitado" ]]; then
  connect_network
elif [[ "$connected" =~ "desabilitado" ]]; then
  enable_network
fi

