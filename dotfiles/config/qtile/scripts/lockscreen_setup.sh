#!/bin/bash

WALLPAPERPATH=/usr/share/backgrounds/dotfiles/wallpaper.jpg

if [ ! -d $HOME/.cache/betterlockscreen ];then
    betterlockscreen -u $WALLPAPERPATH 
fi