#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles 
# in ~/setup_home/dotfiles/
echo "$0 is executing"

# directory with all the new dotfiles
dir=~/setup_home/dotfiles/ubuntu

#### Variables
dt=$(date +%F-%H-%M-%S)
olddir=~/dotfiles_old_$dt

# the names of the files to backup then symlink
bashrc=.bashrc

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~/ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"


# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/setup_home/dotfiles/ubuntu
# directory specified in $files
echo "Moving ~/$bashrc to $olddir/"
sudo mv -f ~/$bashrc $olddir/$bashrc
echo "Creating symlink to $dir/$bashrc in ~/"
sudo ln -s $dir/$bashrc ~/$bashrc

echo "$0 is exiting"
exit
