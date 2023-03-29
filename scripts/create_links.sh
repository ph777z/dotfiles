DOTFILES_PATH=~/.dotfiles

# Paths
if [ ! -d ~/.bin ];then
  echo 'Criando pasta ~/.bin'
  mkdir ~/.bin
fi

if [ ! -d ~/.config ];then
  echo 'Criando pasta ~/.config'
  mkdir ~/.config
fi


# scripts
if [ ! -e ~/.bin/dot-update ];then
  echo 'Criando link simbolico para dot-update'
  ln -sf "${DOTFILES_PATH}/bin/dot-update" ~/.bin/dot-update
fi


# zsh
if [ ! -e ~/.zshrc ];then
  echo 'Criando link simbolico para .zshrc'
  ln -sf "${DOTFILES_PATH}/config/.zshrc" ~/.zshrc
fi
if [ ! -e ~/.config/starship.toml ];then
    echo 'Criando link simbolico para starship.toml'
    ln -sf "${DOTFILES_PATH}/config/starship.toml" ~/.config/starship.toml
fi


# wm
if [ ! -d ~/.config/qtile ];then
  echo 'Criando link simbolico para qtile'
  ln -sf "${DOTFILES_PATH}/config/qtile" ~/.config/qtile
fi


# file manager
if [ ! -d ~/.config/ranger ];then
  echo 'Crianfdo link simbolico para ranger'
  ln -sf "${DOTFILES_PATH}/config/ranger" ~/.config/ranger
fi


# others
if [ ! -e ~/.profile ];then
  echo 'Criando link simbolico para .profile'
  ln -sf "${DOTFILES_PATH}/config/.profile" ~/.profile
fi
