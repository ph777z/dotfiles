#!/bin/bash

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
