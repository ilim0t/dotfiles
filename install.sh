#!/bin/bash
set -u

sudo apt update

# general
sudo apt -y install htop

# zsh
sudo apt -y install zsh git gawk curl
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s $(which zsh)

sudo apt install fzy

# vim
sudo apt install -y vim curl
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

# direnv
sudo apt install -y direnv

# pyenv

# Ubuntu 19以下なら実行
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
curl https://pyenv.run | bash

# pipenv
# Ubuntu 19.04
sudo apt -y install pipenv
# それ以外
pip install pipenv

# pipx
# Ubuntu 19.04
sudo apt -y install pipx
# それ以外
pip install pipx

# tmux
apt install tmux
# tmux source ~/.tmux.conf

# trash-cli
sudo apt -y install trash-cli

# nodejs
sudo apt install nodejs npm
sudo npm install -g n
sudo n stable
sudo apt purge nodejs npm
