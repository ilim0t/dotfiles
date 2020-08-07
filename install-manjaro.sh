#!/bin/bash
set -u

sudo pacman-mirrors --fasttrack && sudo pacman -Syy
sudo pacman -Syu


# yay
sudo pacman -S yay  --noconfirm

# general
yay -Sy git  --noconfirm

# Homebrew on Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap beeftornado/rmtree


# 日本語化
yay -S fcitx-im fcitx-mozc --noconfirm
sudo pacman -S kcm-fcitx  # For KDE


# Application
yay -S visual-studio-code-bin --noconfirm
yay -S google-chrome --noconfirm
yay -S slack-desktop --noconfirm


yay -S htop --noconfirm
yay -S discord --noconfirm
yay -S ngrok --noconfirm
# yay -S tor
# yay -S vlc
# yay -S youtube-dl
yay -S zoom --noconfirm


# Driver
# CUDA
yay -S cuda --noconfirm
# cudnn
yay -S cudnn --noconfirm


# CLI
# docker
yay -S docker --noconfirm
# docker-compose
yay -S docker-compose --noconfirm
# nvidia-docker2
yay -S nvidia-docker --noconfirm

# zsh
yay -S zplug --noconfirm
yay -S fzy --noconfirm

# vim
yay -S vim --noconfirm
yay -S vim-dein --noconfirm

# tmux
yay -S tmux --noconfirm

# tig
yay -S tig --noconfirm

# lazydocker
yay -S lazydocker --noconfirm

# nvtop
yay -S nvtop --noconfirm


# Progmamming language manager
# Python
# pyenv
yay -S pyenv --noconfirm
# pipenv
yay -S python-pipenv --noconfirm
# pipx
yay -S pipx --noconfirm

# Node.js
# nvm
yay -S nvm --noconfirm
# Yarn
yay -S yarn --noconfirm

# Rust
yay -S rust --noconfirm


# Utility
yay -S direnv --noconfirm
yay -S trash-cli --noconfirm
yay -S xclip --noconfirm
yay -S aria2 --noconfirm

# yay -S ttf-ricty --noconfirm