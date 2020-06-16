#!/bin/bash
set -u

# home directory
LANG=C xdg-user-dirs-gtk-update

# git
git config --global user.email "ilim0t14@gmail.com"
git config --global user.name "ilim"

# pyenv
pyenv install 3.8.3

#nvm
nvm install --lts
nvm install-latest-npm

# cpplint
pipx install cpplint

# fonts
# sudo cp * /usr/local/share/fonts/
# sudo fc-cache -fv

# timestamp
timedatectl set-local-rtc 1

# keymap
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# anyconnect
# 自分で