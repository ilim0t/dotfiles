#!/bin/bash
set -u

sudo apt update

# general
sudo apt -y install htop

# zsh
sudo apt -y install zsh git gawk curl
export ZPLUG_HOME=/path/to/.zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s $(which zsh)

# vim
sudo apt install -y vim curl
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >installer.sh
sh ./installer.sh ~/.cache/dein

# direnv
sudo apt install -y direnv

# pyenv
# sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
#     libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
#     xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
# curl https://pyenv.run | bash

# pipenv
sudo apt -y install pipenv

# pipx
sudo apt -y install pipx

# tmux
apt install tmux
# tmux source ~/.tmux.conf
