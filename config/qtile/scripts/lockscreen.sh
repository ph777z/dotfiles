#!/bin/bash

WALLPAPER_PATH=$HOME/.dotfiles/assets/wallpaper.jpg

if [ ! -d $HOME/.cache/betterlockscreen ];then
    betterlockscreen -u $WALLPAPER_PATH 
fi

