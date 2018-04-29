#!/bin/bash

mkdir -p ~/.vim/tmp/
# setup vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo groupadd docker
sudo groupadd wireshark
sudo usermod -aG docker "$(whoami)"
sudo usermod -aG wireshark "$(whoami)"
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# install source code pro
mkdir /tmp/adobefont
cd /tmp/adobefont || exit 1
wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
unzip 1.017R.zip
mkdir -p ~/.fonts
cp source-code-pro-1.017R/OTF/*.otf ~/.fonts/
fc-cache -f -v

cd ~/ || exit 1
# grab oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
# set zsh as the default shell
echo "Enter $(whoami)'s password for chsh"
chsh -s "$(which zsh)"
