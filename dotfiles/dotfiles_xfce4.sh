#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles 
# in ~/setup_home/dotfiles/
echo "$0 is executing"

#### Variables
dir=~/setup_home/dotfiles/xfce
dt=$(date +%F-%H-%M-%S)
olddir=~/dotfiles_old_$dt

# original location of files to backup then symlink
terminal_config_dir=~/.config/xfce4/terminal 
custom_autostart_desk_dir=~/.config/autostart
custom_autostart_script_dir=/usr/local/share

# the names of the files to backup then symlink
terminal_config=terminalrc 
custom_autostart_desk=custom_autostart.desktop 
custom_autostart_script=custom_autostart.sh

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~/ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

# create dirs in ~/ if they don't already exist
mkdir -p $terminal_config_dir 
mkdir -p $custom_autostart_config_dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/setup_home/dotfiles/xfce
# directory specified in $files
echo "Moving $terminal_config_dir/$terminal_config to $olddir/"
mv -f $terminal_config_dir/$terminal_config $olddir/$terminal_config
echo "Creating symlink to $dir/$terminal_config in $terminal_config_dir" 
ln -s $dir/$terminal_config $terminal_config_dir/$terminal_config

echo "Moving $custom_autostart_desk_dir/$custom_autostart_desk to $olddir/"
mv -f $custom_autostart_desk_dir/$custom_autostart_desk $olddir/$custom_autostart_desk
echo "Creating symlink to $dir/$custom_autostart_desk in $custom_autostart_desk_dir"
ln -s $dir/$custom_autostart_desk $custom_autostart_desk_dir/$custom_autostart_desk

echo "Moving $custom_autostart_script_dir/$custom_autostart_script to $olddir/"
sudo mv -f $custom_autostart_script_dir/$custom_autostart_script $olddir/$custom_autostart_script
echo "Creating symlink to $dir/$custom_autostart_script in $custom_autostart_script_dir"
sudo ln -s $dir/$custom_autostart_script $custom_autostart_script_dir/$custom_autostart_script
# make the script executable
sudo chmod a+x $custom_autostart_script_dir/$custom_autostart_script

echo "$0 is exiting"
exit
