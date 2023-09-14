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

## Configuração do firefox

Acesar `about:profiles` no firerox, criar um profile em `~/.mozila/firefox/dot.profile` e o tornar Padrão.

## Fix: Sincronização do vscode

Adicione a seguinte linha em `~/.vscode/argv.json`:

```json
"password-store": "gnome"
```
