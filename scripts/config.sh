#!/bin/bash

#profile config
create_if_not_exists() {
  if [ ! -f $1 ];then
    touch $1
  fi
}

echo_if_never_executed() {
  create_if_not_exists $2
  if [ $(grep -c "${1}" $2) -eq 0 ];then
    echo -e "${1}" >> $2
  fi
}

echo_if_never_executed "export TERMINAL=kitty" ~/.profile 
echo_if_never_executed "export EDITOR=nvim" ~/.profile 