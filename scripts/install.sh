#!/bin/bash

DOTFILES_PATH=$HOME/.dotfiles

declare -a __deps=(
  "xdg-desktop-portal-gtk"
  "flatpak"
  "git"
  "python"
)

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

function install_deps() {
  for dep in "${__deps[@]}"; do
    sudo pacman -S --noconfirm $dep
  done
}

sudo pacman -Sy

install_deps
install_paru

git clone https://github.com/pedrohenrick777/dotfiles.git $DOTFILES_PATH

$DOTFILES_PATH/scripts/install_apps.py
$DOTFILES_PATH/scripts/manual_apps.sh
$DOTFILES_PATH/scripts/config.sh

xdg-user-dirs-update

chsh -s /bin/zsh

sudo systemctl enable docker.service
sudo systemctl enable lightdm.service
systemctl enable --user pipewire.service

sudo usermod -aG docker $USER

reboot_question