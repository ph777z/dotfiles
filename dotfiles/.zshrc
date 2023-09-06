ZSH_CONFIG=$HOME/.config/zsh
ASDF_PATH=$ZSH_CONFIG/asdf

source $ZSH_CONFIG/autosuggetions/zsh-autosuggestions.zsh
source $ZSH_CONFIG/syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG/aliases.zsh

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
