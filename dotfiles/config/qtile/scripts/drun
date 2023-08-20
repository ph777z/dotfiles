#!/bin/env bash


DIRSAPPSBASE=/usr/share/applications:/var/lib/flatpak/exports/share/applications:$HOME/.local/share/applications
IFS=":" read -ra DIRSAPPS <<< $DIRSAPPSBASE
CACHEPATH=$HOME/.cache/drun
LISTAPPSPATH=$CACHEPATH/apps
EXECUTEDFILE=$CACHEPATH/executed

create_list_apps() {
  notify-send 'Scanning Apps'
  if [ -f $EXECUTEDFILE ];then
    rm $EXECUTEDFILE
  fi

  if [ ! -d $LISTAPPSPATH ];then
    mkdir -p $LISTAPPSPATH
  fi

  for dirapps in "${DIRSAPPS[@]}";do
    if [ -d $dirapps ];then
      for app in $(ls $dirapps);do
        if [[ "$app" =~ \.desktop ]];then
          local nameapp=$(cat "$dirapps/$app" | grep -m 1 Name= | awk -F'Name=' '{ print $2 }')
          if [ -f "$LISTAPPSPATH/$nameapp" ];then
            rm "$LISTAPPSPATH/$nameapp"
          fi
          if [[ $dirapps =~ ^[a-zA-Z\/]*(flatpak)[a-zA-Z\/]*$ ]];then
            cp "$dirapps/$app" "$LISTAPPSPATH/$nameapp-flatpak"
          else
            cp "$dirapps/$app" "$LISTAPPSPATH/$nameapp"
          fi
        fi
      done
    fi
  done

  touch $CACHEPATH/executed
}

list_apps() {
  ls $LISTAPPSPATH
  echo 'Scan apps'
}

if [ ! -f $EXECUTEDFILE ];then
  create_list_apps
fi

app=$(list_apps | dmenu -i \
    -nb '#11111b' \
    -nf '#a6adc8' \
    -sb '#a6adc8' \
    -sf '#11111b' \
    -fn "JetBrains:size=10")

case "$app" in
  'Scan apps') create_list_apps ;;
  *) dex --term kitty "$LISTAPPSPATH/$app"
esac