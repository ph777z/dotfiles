#!/bin/sh

if [ -e ~/.fehbg ];then
  sh ~/.fehbg &
else
  ~/.bin/set-background ~/Imagens/backgrounds/default.jpg
fi
picom -f & 
