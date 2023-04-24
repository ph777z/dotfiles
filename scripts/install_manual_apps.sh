#!/bin/bash

# megasync
curl https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst > megasync.pkg.tar.zst
sudo pacman -U --noconfirm megasync.pkg.tar.zst
rm megasync.pkg.tar.zst
