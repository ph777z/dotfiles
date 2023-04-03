#!/bin/bash

DOTFILES_PATH=~/.dotfiles

echo -e "Clonando repositorio\n"
git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH

echo -e "\nInstalando dependencias\n"
$DOTFILES_PATH/scripts/install_apps.py

echo -e "\nClonando Tmux TPM\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e "\nCriando Links\n"
$DOTFILES_PATH/scripts/create_links.sh

echo -e "\nSetando zsh como shell padrão\n"
chsh -s /bin/zsh
