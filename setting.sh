#!/bin/bash
set -u

# home directory
LANG=C xdg-user-dirs-gtk-update

# git
git config --global user.email "ilim0t14@gmail.com"
git config --global user.name "ilim"

# pyenv
pyenv install 3.7.6
pyenv install 3.8.1

# cpplint
pipx install cpplint

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# fonts
sudo cp * /usr/local/share/fonts/
sudo fc-cache -fv