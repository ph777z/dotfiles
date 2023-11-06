ZSH_CONFIG=$HOME/.config/zsh

source $ZSH_CONFIG/aliases.zsh
source $ZSH_CONFIG/catppuccin_mocha-zsh-syntax-highlighting.zsh


PLUGINS_PATH=$ZSH_CONFIG/plugins

if [ ! -d $PLUGINS_PATH/zsh-syntax-highlighting ];then
  echo "Instalando zsh-syntax-highlighting...\n"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_PATH/zsh-syntax-highlighting \
    --branch 0.8.0-alpha1-pre-redrawhook
fi
source "${PLUGINS_PATH}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [ ! -d $PLUGINS_PATH/zsh-autosuggestions ];then
  echo "Instalando zsh-autosuggestions...\n"
  git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_PATH/zsh-autosuggestions
fi
source "${PLUGINS_PATH}/zsh-autosuggestions/zsh-autosuggestions.zsh"


ASDF_PATH=$HOME/.asdf
ASDF_VERSION=v0.13.1

if [ ! -d $ASDF_PATH ];then
    echo "Instalando ASDF...\n"
    git clone https://github.com/asdf-vm/asdf.git $ASDF_PATH --branch $ASDF_VERSION
fi

. $ASDF_PATH/asdf.sh
fpath=(${ASDF_PATH}/completions $fpath)


autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
