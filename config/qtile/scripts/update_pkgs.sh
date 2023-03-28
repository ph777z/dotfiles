#!/bin/sh

udpdate_sytem() {
  clear
  sudo pacman --noconfirm -Syu

  case $? in
    0) printf "\nPacotes atualizados com sucesso";read ;;
    1) printf "\nAtualizacao cancelada";read ;;
  esac
}

check_updates() {
  updates= checkupdates
  if [[ $(echo $updates|wc -l) -eq 0 ]];then
    printf "Sistema atualizado";read
    exit 0
  else
    printf "$updates\n"
  fi
}

main(){
  printf "Verificando atualizacoes\n\n"
  
  check_updates

  read -p "Atualizar pacotes? [S/N] " UPDATES

  case $UPDATES in
    y*|Y*|S*|s*|"") udpdate_sytem ;;
    *) return ;;
  esac
}

main
