#!/bin/bash

WALLPAPERPATH=/usr/share/backgrounds/dotfiles/wallpaper.jpg

if [ ! -d $HOME/.cache/betterlockscreen ];then
    kitty betterlockscreen -u $WALLPAPERPATH 
fi