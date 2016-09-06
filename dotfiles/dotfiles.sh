#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/setup_home/dotfiles/

#### Variables
dir=~/setup_home/dotfiles
# list for files/folder to symlink in homedir
files=".profile .vimrc .gitconfig .gitignore_global .zshrc"

# remove old dotfile if it exists and symlink in the new one
for file in $files; do
    rm -f ~/$file
    ln -s $dir/$file ~/$file
done

mkdir -p ~/.zshrc.d/
ln -s $dir/linux_aliases.sh ~/.zshrc.d/linux_aliases.sh

cd ~
rm ~/.tmux.conf
ln -s $dir/.tmux.conf ~/.tmux.conf

# vim plugin manager (pathogen) and plugins
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle
rm -f ~/.vim/autoload/pathogen.vim
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

cd ~/.vim/bundle
rm -rf vim-markdown
git clone https://github.com/gabrielelana/vim-markdown

cd ~/.vim/bundle
rm -rf vim-markdown-preview
git clone https://github.com/JamshedVesuna/vim-markdown-preview

exit

