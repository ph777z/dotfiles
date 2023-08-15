yay_apps=(
  'betterlockscreen'
  'devour'
)

pacman_apps=(
  'btop'
  'dunst'
  'exa'
  'fd'
  'feh'
  'firefox'
  'flatpak'
  'fzf'
  'kitty'
  'lazygit'
  'mpv'
  'pacman-contrib'
  'pamixer'
  'pavucontrol'
  'picom'
  'python-dbus-next'
  'python-iwlib'
  'python-pillow'
  'python-xlib'
  'qtile'
  'ranger'
  'rofi'
  'starship'
  'tk'
  'tmux'
  'xclip'
  'zathura'
  'zathura-pdf-mupdf'
  'zoxide'
  'zsh'
)

pacman -S --needed $(printf " %s" "${pacman_apps[@]}")
yay -S --needed $(printf " %s" "${yay_apps[@]}")