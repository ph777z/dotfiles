#!/bin/bash

# set wallpaper
WALLPAPERPATH=/usr/share/backgrounds/dotfiles/wallpaper.jpg

if [ ! -e ~/.fehbg ];then
    feh --no-fehbg \
        --bg-scale $WALLPAPER_PATH
else
    $HOME/.fehbg &
fi

# autostart apps
picom -f & 