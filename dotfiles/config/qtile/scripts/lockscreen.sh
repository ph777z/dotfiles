#!/bin/bash

WALLPAPER_PATH=/usr/share/backgrounds/dotfiles/wallpaper.jpg

if [ ! -d $HOME/.cache/betterlockscreen ];then
    betterlockscreen -u $WALLPAPER_PATH 
fi