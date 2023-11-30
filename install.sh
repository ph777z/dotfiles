#!/bin/bash

set -e

sudo -v

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGFILE='dotfiles.log'

yay_apps=(
  'devour'
  'catppuccin-gtk-theme-mocha'
)

pacman_apps=(
  'bat'
  'bluez'
  'btop'
  'bitwarden'
  'blueman'
  'chromium'
  'discord'
  'dunst'
  'eza'
  'fd'
  'feh'
  'firefox'
  'flameshot'
  'flatpak'
  'fzf'
  'lazygit'
  'lightdm'
  'lightdm-gtk-greeter'
  'man-db'
  'mpv'
  'ncspot'
  'neofetch'
  'neovim'
  'nodejs'
  'noto-fonts'
  'noto-fonts-cjk'
  'noto-fonts-emoji'
  'npm'
  'obsidian'
  'openssh'
  'pacman-contrib'
  'pamixer'
  'pavucontrol'
  'picom'
  'pipewire'
  'pipewire-alsa'
  'pipewire-jack'
  'pipewire-pulse'
  'plocate'
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
  'ranger'
  'ripgrep'
  'rofi'
  'slock'
  'starship'
  'syncthing'
  'tk'
  'tmux'
  'ttf-jetbrains-mono-nerd'
  'ueberzug'
  'unzip'
  'vagrant'
  'virtualbox'
  'virtualbox-host-modules-arch'
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
    -e 's/#theme-name=/theme-name=Catppuccin-Mocha-Standard-Sky-Dark/g' \
    -e 's/#font-name=/font-name=JetBrainsMono NF/g' \
    $LIGHTDMCONF
  sudo systemctl enable lightdm.service
}

config_xorg() {
  local XORGCONF=/etc/X11/xorg.conf

  if [ ! -f $XORGCONF ];then
    sudo touch $XORGCONF
  fi

  insert_in() {
    grep -qzoP $1 $XORGCONF || echo -e $2 | sudo tee -a $XORGCONF 1>/dev/null
  }

  insert_in "Section.*ServerFlags.*\n.*DontVTSwitch.*true.*\nEndSection" \
    'Section "ServerFlags"\n\tOption "DontVTSwitch" "true"\nEndSection'
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
  insert_in_profile "export TERMINAL=alacritty"
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

  if [ ! -d $NEOVIM_CONFIG_PATH ];then
    git clone https://github.com/pedrohenrick777/configs.nvim.git $NEOVIM_CONFIG_PATH
  fi

  if ! npm ls -g | grep -q neovim;then
    sudo npm install -g neovim
  fi
}

icons_install() {
  local ICONS_PATH=/usr/share/icons
  local ICONS_VERSION=2023-06-25

  if ! $(ls $ICONS_PATH | grep -q Tela-dark);then

    if [ ! -d $BASEDIR/assets/icons ];then
      git clone https://github.com/vinceliuice/Tela-icon-theme.git $BASEDIR/assets/icons --branch $ICONS_VERSION
    fi

    sudo assets/icons/install.sh -d $ICONS_PATH standard
  fi
}

ranger_config() {
  local RANGER_PLUGINS_PATH=$HOME/.config/ranger/plugins

  ranger_plugin_install() {
    if [ ! -d $RANGER_PLUGINS_PATH/$2 ];then
      git clone $1 "${RANGER_PLUGINS_PATH}/${2}"
    fi
  }

  ranger_plugin_install "https://github.com/alexanderjeurissen/ranger_devicons" "ranger_devicons"
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
  config_xorg

  xdg-user-dirs-update
  sudo chsh -s /bin/zsh $USER
  systemctl enable --user pipewire.service
  sudo systemctl enable bluetooth.service
  sudo modprobe vboxdrv
  sudo updatedb

  dotbot_install
  tmux_config
  neovim_config
  icons_install
  ranger_config

  bat cache --build
}

main | tee -a $LOGFILE