#!/bin/bash

set -e

sudo -v

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGFILE='dotfiles.log'

yay_apps=(
  'devour'
  'betterlockscreen'
  'catppuccin-gtk-theme-mocha'
  'visual-studio-code-bin'
)

pacman_apps=(
  'alacritty'
  'bat'
  'bluez'
  'btop'
  'blueman'
  'dunst'
  'eza'
  'fd'
  'feh'
  'firefox'
  'flatpak'
  'fzf'
  'gnome-keyring'
  'kitty'
  'lazygit'
  'lightdm'
  'lightdm-gtk-greeter'
  'mpv'
  'neovim'
  'nodejs'
  'noto-fonts'
  'noto-fonts-cjk'
  'noto-fonts-emoji'
  'npm'
  'openssh'
  'pacman-contrib'
  'pamixer'
  'pavucontrol'
  'picom'
  'pipewire'
  'pipewire-alsa'
  'pipewire-jack'
  'pipewire-pulse'
  'python'
  'python-dbus-next'
  'python-iwlib'
  'python-pillow'
  'python-pip'
  'python-pynvim'
  'python-xlib'
  'qtile'
  'qt5ct'
  'qt6ct'
  'qutebrowser'
  'ranger'
  'ripgrep'
  'rofi'
  'rust'
  'starship'
  'tk'
  'tmux'
  'ttf-jetbrains-mono'
  'ttf-nerd-fonts-symbols'
  'ttf-nerd-fonts-symbols-common'
  'ttf-nerd-fonts-symbols-mono'
  'ueberzug'
  'unzip'
  'wget'
  'wireplumber'
  'xclip'
  'xdg-desktop-portal-gtk'
  'xdg-user-dirs'
  'xorg-apps'
  'xorg-server'
  'zathura'
  'zathura-pdf-mupdf'
  'zip'
  'zoxide'
  'zsh'
)

yay_install() {
  local YAYDIR=$BASEDIR/yay
  if ! command -v yay 1>/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git $YAYDIR\
      && cd $YAYDIR \
      && makepkg -si --noconfirm \
      && cd $BASEDIR \
      && rm -rf $YAYDIR
  fi
}

config_lighdm() {
  local BACKGROUNDSSOURCE=$BASEDIR/assets/backgrounds
  local BACKGROUNDSDIR=/usr/share/backgrounds/dotfiles
  local LIGHTDMCONF=/etc/lightdm/lightdm-gtk-greeter.conf

  if [ ! -d $BACKGROUNDSDIR ];then
    sudo mkdir -p $BACKGROUNDSDIR
  fi

  sudo cp $BACKGROUNDSSOURCE/wallpaper.jpg $BACKGROUNDSDIR
  sudo sed -i \
    -e 's/#background=/background=\/usr\/share\/backgrounds\/dotfiles\/wallpaper.jpg/g' \
    $LIGHTDMCONF
  sudo systemctl enable lightdm.service
}

config_sudoers() {
  local SUDOERSCONF=/etc/sudoers
  sudo sed -i \
    -e 's/# Defaults secure_path/Defaults secure_path/g' \
    -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' \
    $SUDOERSCONF
}

config_pacman() {
  local PACMANCONF=/etc/pacman.conf

  sudo sed -i "s/^#Color$/Color/g" \
    $PACMANCONF
}

config_profile() {
  local PROFILEPATH=$HOME/.profile

  insert_in_profile() {
    grep -qxF "${1}" $PROFILEPATH \
      || echo $1 >> $PROFILEPATH
  }

  if [ ! -f $PROFILEPATH ];then
    touch $PROFILEPATH
  fi
  insert_in_profile "export TERMINAL=kitty"
  insert_in_profile "export EDITOR=nvim"
  insert_in_profile 'export QT_QPA_PLATFORMTHEME="qt5ct"'
}

dotbot_install() {
  local CONFIG="install.conf.yaml"
  local DOTBOT_DIR="dotbot"
  local DOTBOT_BIN="bin/dotbot"

  cd "${BASEDIR}"
  git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
  git submodule update --init --recursive "${BASEDIR}"

  "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
}

tmux_config() {
  local TPM_PATH=$HOME/.tmux/plugins/tpm

  if [ ! -d $TPM_PATH ];then
    git clone https://github.com/tmux-plugins/tpm $TPM_PATH\
      && $TPM_PATH/bin/install_plugins
  fi
}

neovim_config() {
  local NEOVIM_CONFIG_PATH=$HOME/.config/nvim

  git clone https://github.com/pedrohenrick777/configs.nvim.git $NEOVIM_CONFIG_PATH
}

icons_install() {
  local ICONS_PATH=/usr/share/icons

  if ! $(ls $ICONS_PATH | grep -q Tela-dark);then
    sudo assets/icons/install.sh -d $ICONS_PATH standard
  fi
}

main() {
  yay_install

  sudo pacman -Sy
  sudo pacman -S --needed --noconfirm $(printf " %s" "${pacman_apps[@]}")
  yay -S --needed --noconfirm $(printf " %s" "${yay_apps[@]}")

  config_lighdm
  config_sudoers
  config_profile
  config_pacman

  xdg-user-dirs-update
  sudo chsh -s /bin/zsh $USER
  systemctl enable --user pipewire.service
  sudo systemctl enable bluetooth.service
  sudo npm install -g neovim

  dotbot_install
  tmux_config
  neovim_config
  icons_install

  bat cache --build
}

main | tee -a $LOGFILE