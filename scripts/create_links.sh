#!/bin/bash

DOTFILES_PATH=~/.dotfiles

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

# Paths
if [ ! -d ~/.local/bin ];then
  echo 'Criando pasta ~/.local/bin'
  mkdir -p ~/.local/bin
fi

if [ ! -d ~/.config ];then
  echo 'Criando pasta ~/.config'
  mkdir ~/.config
fi

if [ ! -d ~/.local/share/fonts ];then
  echo "Criando pasta de fontes"
  mkdir -p ~/.local/share/fonts
fi

if [ ! -d ~/Imagens/backgrounds ];then
  echo 'Criando pasta de backgrounds'
  mkdir ~/Imagens/backgrounds
fi

ln -sf $DOTFILES_PATH/bin/* ~/.local/bin
ln -sf $DOTFILES_PATH/assets/backgrounds/* ~/Imagens/backgrounds
ln -sf $DOTFILES_PATH/assets/fonts/* ~/.local/share/fonts

create_link .zshrc
create_link .profile
create_link .tmux.conf

create_link lvim .config
$HOME/.local/bin/lvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" 
create_link qtile .config
create_link kitty .config
create_link picom .config
create_link ranger .config
create_link starship.toml .config
