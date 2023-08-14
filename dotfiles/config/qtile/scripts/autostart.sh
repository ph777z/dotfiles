#!/bin/bash

# set wallpaper
if [ ! -e ~/.fehbg ];then
    feh --no-fehbg --bg-scale $HOME/.dotfiles/assets/wallpaper.jpg &
else
    $HOME/.fehbg &
fi

# autostart apps
picom -f & 
