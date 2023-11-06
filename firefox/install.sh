#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d $HOME/.mozilla/firefox ];then
  echo "A pasta de configuração do firefox não existe, por favor inicie o firefox antes de rodar este script."
  exit 1
fi

cd $HOME/.mozilla/firefox/*.default-release

if [ -f user.js ];then
  echo "Removendo arquivo de configuração antigo"
  rm user.js
fi
echo "Copiando arquivo de configuração"
cp $BASEDIR/user.js .

FIREFOX_THEME=https://codeberg.org/Freeplay/Firefox-Onebar.git

if [ ! -d chrome ];then
  echo "Clonando tema do firefox"
  git clone https://codeberg.org/Freeplay/Firefox-Onebar.git chrome
else
  echo "Atualizando tema do firefox"
  cd chrome
  git pull
fi
