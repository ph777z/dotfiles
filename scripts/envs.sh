if [ ! -z $SUDO_USER ];then
    export SCRIPT_USER=$SUDO_USER
else
    export SCRIPT_USER=$USER
fi

export DOTFILES_PATH=$HOME/.dotfiles
export SCRIPTS_PATH=$DOTFILES_PATH/scripts
