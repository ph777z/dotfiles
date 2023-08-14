export PATH="$PATH:$HOME/.cargo/bin:$HOME/.bin:$HOME/.local/bin"

##########################
##        PLUGINS       ##
##########################
if [ ! -d ~/.zsh ];then
  mkdir ~/.zsh
fi

if [ ! -d ~/.zsh/zsh-autosuggestions ];then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d ~/.zsh/zsh-syntax-highlighting ];then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##########################
##        ASDF          ##
##########################
if [ ! -d ~/.asdf ];then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
fi

. ~/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

#########################
##       ALIASES      ###
#########################
alias exa="exa --icons"
alias l="exa"
alias ll="exa -l"
alias la="exa -a"
alias lla="exa -la"
alias tree="exa -T"
alias rm="rm -r"

alias mpv="devour mpv"
alias zathura="devour zathura"
alias frun="devour flatpak run"

venv() {
  if [ ! -d ./.venv ];then
    python -m venv .venv
  fi

  source ./.venv/bin/activate
}

#########################
##      CONFIGS        ##
#########################
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
