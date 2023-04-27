#!/bin/bash

# autostart extend
if [ -e ~/.autostart ];then
 ~/.autostart
fi

# set wallpaper
if [ -e ~/.fehbg ];then
  ~/.fehbg &
else
  ~/.local/bin/set-background ~/Imagens/backgrounds/default.jpg
fi

# autostart apps
picom -f & 
megasync &
