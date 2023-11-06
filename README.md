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

- É preciso iniciar o firefox ao menos 1 vez para que isto funcione.
- O script instalará as configurações apenas no usuário padrão do firefox

```bash
cd firefox
./install.sh
```

## Configurando o teclado pelo qtile

Adicione o formato de teclado desejado em `~/.kbconfig`