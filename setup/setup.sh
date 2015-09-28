#!/bin/bash
echo "$0 is executing"

sudo groupadd docker

# install source code pro
mkdir /tmp/adobefont
cd /tmp/adobefont
wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
unzip 1.017R.zip 
mkdir -p ~/.fonts
cp source-code-pro-1.017R/OTF/*.otf ~/.fonts/
fc-cache -f -v
cd  ~/
rm -rf /tmp/adobefont

SAVE_DIR=`pwd`
cd ~/
# grab oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
# set zsh as the default shell
sudo chsh -s $(which zsh) $(whoami)
cd $SAVE_DIR

echo "$0 is exiting"
