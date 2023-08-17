#!/bin/bash

# set wallpaper
if [ ! -e ~/.fehbg ];then
    feh --no-fehbg \
        --bg-scale /usr/share/dotfiles/wallpaper.jpg
else
    $HOME/.fehbg &
fi

# autostart apps
picom -f & 