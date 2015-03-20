setup_home
==========
This repository includes all of my current custom dotfiles and setup/install
scripts. This repository should be cloned to your home directory so that the
path is `~/setup_home/`. The included setup scripts install a bunch of
packages, run any setup instructions, then backup your current dotfiles that
will be replace in your home directory, by placing them in ~/dotfiles_old/,
and then symlinking to the dotfiles in this directory structure. 

Current commands supported:
xfce4, jeff

First this set of scripts installs software to your machine. install.sh is the
first script to run followed by each install_[command].sh. You can add your own
commands by simply adding the install_[command].sh file. 

Next the setup.sh script is run. This is for generic setup commands that do not
involve installing software. Next each setup_[command].sh script is run. You
can add your own commands by simply adding the setup_[command].sh file. 

You do not need to add both the install_[command].sh and the setup_[command].sh
files. If one or both do not exist, even though the command was supplied at the
command line, it will be skipped.

Next, the dotfiles.sh script runs, which sets up dotfiles in your home 
directory. The files placed in your home directory are symlinks to the 
actual dotfiles stored in ./dotfiles/.

Installation
------------

``` bash
git clone git@github.com:therealjumbo/setup_home.git ~/setup_home
chmod a+x run.sh
./run.sh [commands]
```
