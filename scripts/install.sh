#!/bin/bash

DOTFILES_PATH=$HOME/.dotfiles

function install_paru() {
  git clone https://aur.archlinux.org/paru-bin.git $HOME/paru
  cd ~/paru
  makepkg --noconfirm -si
  cd $HOME
  rm -rf $HOME/paru
}

function reboot_question() {
  echo -e "\nReiniciar o sistema agora? [S/N] "
  read reiniciar

  case $reiniciar in
    y*|Y*|s*|S*) reboot ;;
    *) exit 0 ;;
  esac
}

function post_apps_installation() {
  $DOTFILES_PATH/scripts/config.sh

  xdg-user-dirs-update

  chsh -s /bin/zsh

  sudo systemctl enable docker.service
  sudo systemctl enable lightdm.service
  systemctl enable --user pipewire.service

  sudo usermod -aG docker $USER
}

function main() {
  git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH
  
  sudo pacman -Sy

  $DOTFILES_PATH/scripts/apps.sh
  
  post_apps_installation
  
  reboot_question
}
