#!/bin/bash
echo "$0 is executing"

cur_dir=`pwd`

# install the solarized theme for gnome-terminal
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git ~/gnome-solarized/
cd ~/gnome-solarized/
./install.sh

# install the "ls fix"
git clone https://github.com/seebi/dircolors-solarized.git ~/.dircolors/

cd $cur_dir

echo "$0 is exiting"
