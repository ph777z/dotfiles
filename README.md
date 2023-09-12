# Dotfiles

- **Os:** [Arch](https://archlinux.org)
- **Wm:** [qtile](http://www.qtile.org)
- **Terminal:** [kitty](https://sw.kovidgoyal.net/kitty)

## Install

```bash
git clone https://github.com/pedrohenrick777/dotfiles.git ~/.dotfiles
cd .dotfiles
./install.sh
```

## Fix: Sincronização do vscode

Adicione a seguinte linha em `~/.vscode/argv.json`:

```json
"password-store": "gnome"
```