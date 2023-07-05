export PATH=~/.npm-global/bin:$PATH
export TERMINAL=kitty
export EDITOR=nvim
export DOTFILES_PATH=$HOME/.dotfiles

if [ -e ~/.profile-extend ];then
  source ~/.profile-extend
fi
