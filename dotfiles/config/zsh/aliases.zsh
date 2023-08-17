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