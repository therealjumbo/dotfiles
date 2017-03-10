# setup_home
==========
This repository includes all of my current custom dotfiles and setup/install
scripts. The included `run.sh` script runs other scripts that
install a bunch of packages, run any setup instructions,  symlinking the
dotfiles in this repo to the apropriate location.

### Current commands supported:
* `jeff`

## Installation

``` bash
git clone https://github.com:therealjumbo/setup_home.git
cd ~/setup_home/
chmod a+x run.sh
```

## Operation
``` bash
./run.sh [commands]
```

1. `./run.sh` should be the script that the user runs normally, although the other
scripts can be run independently.

2. Next, the `./install/install.sh` script is run followed by each
`./install/install_[command].sh`. These scripts are for installing packages and
other software. 

3. Next, the `./setup/setup.sh` script is run followed by each
`./setup/setup_[command].sh`. These scripts are for any setup commands that
do not involve installing software or symlinking dotfiles. 

4. Next, the `~/setup_home/dotfiles/dotfiles.sh` script is run followed by each
`~/setup_home/dotfiles/dotfiles_[command].sh`. These scripts are for all
symlinking the dotfiles inside this repo to the appropriate location in the home
direcotry. 

If you want to add a new command, you do not need to add all three scripts:
* `install_[command].sh`
* `setup_[command].sh`
* `dotfiles_[command].sh`
You only need to add the scripts you require. The others will be searched for in
their respective directories, and when they are not found, the script will
simply continue.

## Notes
Other things to setup (optional) after this runs:
* system proxy
* apt-get proxy
* gnome extensions
    * Alternatetab
    * Media player indicator
    * No topleft hot corner
    * Windownavigator
    * Removable drive menu
* remap CAPS to Ctrl
* generate new ssh keys for system
* setup keypass
* setup firefox sync
