#!/bin/bash

DOTFILES_PATH=~/.dotfiles

# Paths
if [ ! -d ~/.bin ];then
  echo 'Criando pasta ~/.bin'
  mkdir ~/.bin
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


# scripts
ln -sf $DOTFILES_PATH/bin/* ~/.bin


# zsh
if [ ! -e ~/.zshrc ];then
  echo 'Criando link simbolico para .zshrc'
  ln -sf "${DOTFILES_PATH}/config/.zshrc" ~/.zshrc
fi
if [ ! -e ~/.config/starship.toml ];then
  echo 'Criando link simbolico para starship.toml'
  ln -sf "${DOTFILES_PATH}/config/starship.toml" ~/.config/starship.toml
fi


# wm
if [ ! -d ~/.config/qtile ];then
  echo 'Criando link simbolico para qtile'
  ln -sf "${DOTFILES_PATH}/config/qtile" ~/.config/qtile
fi


# file manager
if [ ! -d ~/.config/ranger ];then
  echo 'Crianfdo link simbolico para ranger'
  ln -sf "${DOTFILES_PATH}/config/ranger" ~/.config/ranger
fi


# terminal
if [ ! -d ~/.config/kitty ];then
  echo 'Criando link simbolico para kitty'
  ln -sf "${DOTFILES_PATH}/config/kitty" ~/.config/kitty
fi


# tmux
if [ ! -e ~/.tmux.conf ];then
  echo 'Criando link simbolico para tmux'
  ln -sf "${DOTFILES_PATH}/config/.tmux.conf" ~/.tmux.conf
fi


# picom
if [ ! -d ~/.config/picom ];then
  echo 'Criando link simbolico para picom'
  ln -sf "${DOTFILES_PATH}/config/picom" ~/.config/picom
fi


# lvim
if [ ! -d ~/.config/lvim ];then
  echo 'Criando link simbolico para lvim'
  ln -sf "${DOTFILES_PATH}/config/lvim" ~/.config/lvim
fi


# others
if [ ! -e ~/.profile ];then
  echo 'Criando link simbolico para .profile'
  ln -sf "${DOTFILES_PATH}/config/.profile" ~/.profile
fi


# assets
ln -sf $DOTFILES_PATH/assets/backgrounds/* ~/Imagens/backgrounds
ln -sf $DOTFILES_PATH/assets/fonts/* ~/.local/share/fonts
