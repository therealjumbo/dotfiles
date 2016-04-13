#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles 
# in ~/setup_home/dotfiles/

echo "$0 is executing"

#### Variables
dir=~/setup_home/dotfiles
dt=$(date +%F-%H-%M-%S)
olddir=~/dotfiles_old_$dt
# list for files/folder to symlink in homedir
files=".profile .vimrc gitconfig .gitignore_global .zshrc" 
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
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir/"
    mv -f ~/$file $olddir/
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file ~/$file
done

cd ~
ln -s $dir/.tmux.conf ~/.tmux.conf
mkdir -p .bin
ln -s $dir/tmuxinator.zsh ~/.bin/tmuxinator.zsh

# vim plugin manager (pathogen) and plugins
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle 
rm ~/.vim/autoload/pathogen.vim
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
rm -rf vim-colors-solarized
git clone https://github.com/altercation/vim-colors-solarized.git

cd ~/.vim/bundle
rm -rf vim-sleuth
git clone https://github.com/tpope/vim-sleuth.git

echo "$0 is exiting"
exit

