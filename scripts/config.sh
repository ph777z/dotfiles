#!/bin/bash

function create_link() {
  if [ ! -z "$2" ];then
    local LINK_PATH="$HOME/$2/$1"
  else
    local LINK_PATH="$HOME/$1"
  fi

  if [ -d $LINK_PATH ] || [ -e $LINK_PATH ];then
    if ! file -s $LINK_PATH | rg "symbolic link" &>/dev/null;then
      mv $LINK_PATH "$LINK_PATH.bkp"
    else
      return
    fi
  fi

  ln -sf "$DOTFILES_PATH/config/$1" "$LINK_PATH" 
}

function make_dir() {
  if [ ! -d $1 ];then
    mkdir -p $1
  fi
}

function config_tmux() {
  if [ ! -d ~/.tmux/plugins/tpm ];then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  if [ ! -d ~/.tmux/plugins/tmux-themepack ];then
    git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/plugins/tmux-themepack
  fi

  if [ ! -d ~/.tmux/plugins/vim-tmux-navigator ];then
    git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.tmux/plugins/vim-tmux-navigator
  fi
}

function config_npm() {
  make_dir $HOME/.npm-global
  npm config set prefix '~/.npm-global'
}


make_dir $HOME/.local/bin
make_dir $HOME/.config
make_dir $HOME/.local/share/fonts

ln -sf $DOTFILES_PATH/bin/* ~/.local/bin
ln -sf $DOTFILES_PATH/assets/fonts/* ~/.local/share/fonts

create_link .zshrc
create_link .profile
create_link .tmux.conf
create_link .gitconfig

create_link qtile .config
create_link kitty .config
create_link picom .config
create_link ranger .config
create_link starship.toml .config
