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
keybindings_desktop_dir=~/.config/autostart
# the names of the files to backup then symlink
terminal_config=terminalrc 
keybindings_desktop=keybindings.desktop

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
mkdir -p $keybindings_desktop_dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/setup_home/dotfiles/xfce
# directory specified in $files
echo "Moving $terminal_config_dir/$terminal_config to $olddir/"
mv -f $terminal_config_dir/$terminal_config $olddir/$terminal_config
echo "Creating symlink to $dir/$terminal_config in $terminal_config_dir" 
ln -s $dir/$terminal_config $terminal_config_dir/$terminal_config

echo "Moving $keybindings_desktop_dir/$keybindings_desktop to $olddir/"
mv -f $keybindings_desktop_dir/$keybindings_desktop $olddir/$keybindings_desktop
echo "Creating symlink to $dir/$keybindings_desktop in $keybindings_desktop_dir"
ln -s $dir/$keybindings_desktop $keybindings_desktop_dir/$keybindings_desktop
# the script used by that config must be executable
chmod a+x $dir/keybindings.sh
echo "$0 is exiting"
exit
