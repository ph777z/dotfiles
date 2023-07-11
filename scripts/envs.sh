if [ ! -z $SUDO_USER ];then SCRIPT_USER=$SUDO_USER; else SCRIPT_USER=$USER; fi

export $SCRIPT_USER
export DOTFILES_PATH=$HOME/.dotfiles
export SCRIPTS_PATH=$DOTFILES_PATH/scripts
