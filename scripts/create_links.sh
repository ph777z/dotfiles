#!/bin/bash

DOTFILES_PATH=~/.dotfiles

function create_link() {
  if [ -d $2 ];then
    if ! file -s $2 | rg "symbolic link";then
      mv $2 "$2.bkp"
    fi
  fi

  ln -sf $1 $2 
}


# Paths
if [ ! -d ~/.bin ];then
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

create_link "${DOTFILES_PATH}/config/.zshrc" ~/.zshrc
create_link "${DOTFILES_PATH}/config/starship.toml" ~/.config/starship.toml
create_link "${DOTFILES_PATH}/config/qtile" ~/.config/qtile
create_link "${DOTFILES_PATH}/config/ranger" ~/.config/ranger
create_link "${DOTFILES_PATH}/config/kitty" ~/.config/kitty
create_link "${DOTFILES_PATH}/config/.tmux.conf" ~/.tmux.conf
create_link "${DOTFILES_PATH}/config/picom" ~/.config/picom
create_link "${DOTFILES_PATH}/config/lvim" ~/.config/lvim
create_link "${DOTFILES_PATH}/config/.profile" ~/.profile
