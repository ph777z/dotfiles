#!/bin/bash

# set wallpaper
if [ -e ~/.fehbg ];then
  ~/.fehbg &
else
  ~/.local/bin/set-background ~/Imagens/backgrounds/default.jpg
fi

# autostart apps
picom -f & 
megasync &
