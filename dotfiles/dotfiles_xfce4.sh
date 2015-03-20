#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles 
# in ~/setup_home/dotfiles/
echo "$0 is executing"

#### Variables
dir=~/setup_home/dotfiles
olddir=~/dotfiles_old

terminal_config_dir="~/.config/xfce4/terminal" # location of file to backup then symlink
terminal_config="terminalrc" # a file to backup then symlink
####

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~/ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/setup_home/dotfiles directory
# specified in $files
echo "Moving $terminal_config_dir/$terminal_config to $olddir/"
mv -f $terminal_config_dir/$terminal_config $olddir/$terminal_config
echo "Creating symlink to $dir/$terminal_config in $terminal_config_dir" 
ln -s $dir/$terminal_config $terminal_config_dir/$terminal_config

echo "$0 is exiting"
exit
