#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/setup_home/dotfiles/

echo "$0 is executing"

#### Variables
dir=~/setup_home/dotfiles
# list for files/folder to symlink in homedir
files=".profile .vimrc .gitconfig .gitignore_global .zshrc"

# remove old dotfile if it exists and symlink in the new one
for file in $files; do
    rm ~/$file
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

cd ~/.vim/bundle
rm -rf vim-better-whitespace
git clone https://github.com/ntpeters/vim-better-whitespace.git ~/.vim/bundle/vim-better-whitespace

cd ~/.vim/bundle
rm -rf nerdtree
git clone https://github.com/scrooloose/nerdtree.git

echo "$0 is exiting"
exit

