#!/bin/bash

DOTFILES_PATH=~/.dotfiles

echo "Clonando repositorio"
git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH

echo -e "Criando Links\n"
bash -c "${DOTFILES_PATH}/scripts/create_links.sh"
