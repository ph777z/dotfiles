#!/bin/sh

if [ ! -e ~/.fehbg ];then
  sh ~/.fehbg &
else
  feh --bg-scale --no-fehbg ~/Imagens/backgrounds/walpaper1.jpg &
fi
picom -f & 
