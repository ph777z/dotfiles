#!/bin/bash

DOTFILES_PATH=~/.dotfiles

echo -e "Clonando repositorio\n"
git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH

echo -e "\nInstalando dependencias\n"
python "${DOTFILES_PATH}/scripts/install_apps.py"

echo -e "\nCriando Links\n"
bash "${DOTFILES_PATH}/scripts/create_links.sh"
