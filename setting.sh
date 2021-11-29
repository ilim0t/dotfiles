#!/bin/bash
set -u

# home directory
sudo apt-get install xdg-user-dirs-gtk # KDEのみ
LANG=C xdg-user-dirs-gtk-update
sudo apt-get purge xdg-user-dirs-gtk # KDEのみ

# git
git config --global user.email "ilim0t14@gmail.com"
git config --global user.name "ilim"

git config --global commit.gpgsign true
git config --global tag.gpgSign true
git config --global user.signingkey 404D725FE3C50AE0

# pyenv
# pyenv install 3.9.9

# nvm
nvm install stable --latest-npm

# cpplint
# pipx install cpplint

# fonts
# sudo cp * /usr/local/share/fonts/
# sudo fc-cache -fv

# timestamp
timedatectl set-local-rtc 1

# keymap
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

# anyconnect
# 自分で

# Swapfile
sudo swapoff /swapfile
sudo fallocate -l 4G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Auto mount
# 自分で
