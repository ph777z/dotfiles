DOTFILES_PATH="~/.dotfiles"

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

if [ ! -d ~/.config/qtile ];then
  echo 'Criando link simbolico para qtile'
  ln -sf "${DOTFILES_PATH}/config/qtile" ~/.config/teste
fi
