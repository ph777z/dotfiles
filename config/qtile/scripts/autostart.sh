#!/bin/sh

# autostart extend
if [ -e ~/.autostart ];then
 ~/.autostart
fi

# set wallpaper
if [ -e ~/.fehbg ];then
  sh ~/.fehbg &
else
  ~/.bin/set-background ~/Imagens/backgrounds/default.jpg
fi

# autostart apps
picom -f & 
