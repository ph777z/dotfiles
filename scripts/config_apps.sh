#!/bin/bash

# Tmux
if [ ! -d ~/.tmux/plugins/tpm ];then
  echo -e "\nClonando Tmux TPM\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.tmux/plugins/tmux-themepack ];then
  echo -e "\nClonando tmux-theme\n"
  git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/plugins/tmux-themepack
fi

if [ ! -d ~/.tmux/plugins/vim-tmux-navigator ];then
  echo -e "\nClonando tmux-theme\n"
  git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.tmux/plugins/vim-tmux-navigator
fi


# npm
if [ ! -d ~/.npm-global ];then
  echo -e "\nConfigurando npm\n"
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
fi


# lvim
if command -v lvim; then
  LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh) --no-install-dependencies
fi
