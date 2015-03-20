setup_home
==========
This repository includes all of my current custom dotfiles and setup/install
scripts. This repository should be cloned to your home directory so that the
path is `~/setup_home/`. The included `run.sh` script runs other scripts that
install a bunch of packages, run any setup instructions, backup your 
current dotfiles to `~/dotfiles_old_$(date +%F-%H-%M-%S)/` that will then be 
replaced by symlinking to the dotfiles in this directory structure. 

Current commands supported:
`xfce4`, `jeff`

`~/setup_home/run.sh` should be the script that the user runs.

Next, the `~/setup_home/install/install.sh` script is run followed by each 
`~/setup_home/install/install_[command].sh`. These scripts are for installing 
packages and other software. You can add your own commands by simply adding the 
appropriate `install_[command].sh` file.

Next, the `~/setup_home/setup/setup.sh` script is run followed by each
`~/setup_home/setup/setup_[command].sh`. These scripts are for generic setup 
commands that do not involve installing software or dotfiles. You can add your 
own commands by simply adding the appropriate `setup_[command].sh` file. 

Next, the `~/setup_home/dotfiles/dotfiles.sh` script is run followed by each
`~/setup_home/dotfiles/dotfiles_[command].sh`. These scripts are for backing up 
all dotfiles in your home dir that will be replaced and then symlinking to the 
appropriate files under `~/setup_home/dotfiles` from the same location in the 
home dir. You can add your own commands by simply adding the 
appropriate `dotfiles_[command].sh` file.

If you want to add a new command, you do not need to all three scripts:
`install_[command].sh`, `setup_[command].sh`, and `dotfiles_[command].sh`. You
only need to add the scripts you require. The others will be searched for in
their respective directories, and when they are not found, the script will
simply continue.

Installation
------------

``` bash
git clone git@github.com:therealjumbo/setup_home.git ~/setup_home
cd ~/setup_home/
chmod a+x run.sh
./run.sh [commands]
```
