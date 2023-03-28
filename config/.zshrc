###################
#   zsh config    #
###################
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

###################
#      asdf       #
###################
. $HOME/.asdf/asdf.sh


###################
#     aliases     #
###################
alias exa="exa --icons"
alias l="exa"
alias ll="exa -l"
alias la="exa -la"
alias rm="rm -r"

alias mpv="devour mpv"
alias zathura="devour zathura"
alias frun="devour flatpak run"


###################
# autocompletions #
###################
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit


###################
#  case-sensitive #
###################
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'


###################
#      paths      #
###################
export PATH="$PATH:$HOME/.cargo/bin/"
