#!/bin/bash
set -u

sudo apt update


# General
sudo apt install -y cmake curl git

# Homebrew on Linux
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash -s -- -y
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
brew tap beeftornado/rmtree


# Application
# Chrome https://www.google.com/chrome/

# Slack https://slack.com/intl/ja-jp/downloads/linux
# deb版でないと日本語入力ができない
# sudo snap install slack --classic

# Visual Studio Code https://code.visualstudio.com/download
# deb版でないと日本語入力ができない
# sudo snap install code --classic

# Zoom https://zoom.us/download?os=linux
# deb版でないとURLでxdg-openされない

# WPS Office http://linux.wps.com/

# Steam https://store.steampowered.com/about/
# libGL error: failed to load driver: swrast
# というエラーが出る場合以下を実行 (i86は必要なのかちゃんと確認できていない)
# sudo apt install libnvidia-gl-***:i386

# Snap
sudo snap install htop
# sudo snap install discord
# sudo snap install libreoffice
sudo snap install ngrok
# sudo snap install tor
sudo snap install vlc
sudo snap install youtube-dl
# sudo snap install zoom-client


# Driver
# CUDA
# https://developer.nvidia.com/cuda-downloads に従う
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda-11-0

# cuDNN
# https://developer.nvidia.com/rdp/cudnn-download に従い3つのdebをinstallする


# Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs)  \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# sudo apt install -y docker.io
# sudo systemctl enable --now docker

# sudo groupadd docker  # 問題なければこのまま削除
sudo gpasswd -a $USER docker

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# nvidia-docker2
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-docker2
sudo systemctl restart docker


# CLI
# zsh
sudo apt install -y zsh gawk
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
sudo chsh -s $(which zsh) $USER

sudo apt install fzy

# Vim
sudo apt install -y vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s -- ~/.cache/dein

# tmux
sudo apt install -y tmux
# tmux source ~/.tmux.conf

# tig
sudo apt install -y tig

# lazydocker
brew install jesseduffield/lazydocker/lazydocker

# nvtop
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
sudo apt install -y libncurses5-dev
cmake ..
sudo apt purge -y libncurses5-dev
sudo make install

cd ../../
rm -rf nvtop


# Progmamming language manager
# Python
# pyenv
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
curl https://pyenv.run | bash

# Pipenv
sudo apt install -y pipenv python3-venv  # virtualenv 問題なければvirtualenvを実際に削除予定

# pipx
sudo apt install -y pipx

# Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


# Utility
sudo apt install -y openssh-server
sudo apt install -y direnv
sudo apt install -y trash-cli
sudo apt install -y xclip
sudo apt install -y aria2
brew install ncdu
brew install glances
snap install ksuperkey # KDEのみ

# Font
brew tap sanemat/font
brew install ricty --with-powerline
sudo cp -f /home/linuxbrew/.linuxbrew/opt/ricty/share/fonts/Ricty*.ttf /usr/local/share/fonts/

sudo apt install fonts-firacode

fc-cache -vf