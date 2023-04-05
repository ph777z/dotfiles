#!/bin/bash

DOTFILES_PATH=~/.dotfiles

echo -e "Clonando repositorio\n"
git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH

echo -e "\nInstalando dependencias\n"
$DOTFILES_PATH/scripts/install_apps.py
$DOTFILES_PATH/scripts/config_apps.sh
$DOTFILES_PATH/scripts/create_links.sh
xdg-user-dirs-update


echo -e "\nSetando zsh como shell padrão\n"
chsh -s /bin/zsh

echo -e "\nAtivando servicos systemd\n"
sudo systemctl enable docker.service
sudo systemctl enable lightdm.service

echo -e "\nPermissão de acesso ao docker\n"
sudo usermod -aG docker $USER

echo -e "\nReiniciar o sistema agora? [S/N] "
read reiniciar

case $reiniciar in
  y*|Y*|s*|S*) reboot ;;
  *) exit 0 ;;
esac
