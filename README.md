# setup_home
==========
This repository includes all of my current custom dotfiles and setup/install
scripts. The included `run.sh` script runs other scripts that
install a bunch of packages, run any setup instructions,  symlinking the
dotfiles in this repo to the apropriate location.

## Install

``` bash
git clone https://github.com:therealjumbo/setup_home.git
cd setup_home
```

## Use
``` bash
./run.sh
```

1. `./run.sh` should be the script that the user runs normally, although the other
scripts can be run independently.

2. The `./install/install.sh` script is run. This script just installs software
packages.

3. The `./setup/setup.sh` script is run. This script is for any setup 
commands that do not involve installing software or symlinking dotfiles. 

4. The `./dotfiles/dotfiles.sh` script is run. This script is
for symlinking the dotfiles inside this repo to the appropriate location in the 
home directory. 

5. Each file in `./usr-bin/` is symlinked into `/usr/local/bin/`

## Notes
Other things to setup (optional) after this runs:
* system proxy
* apt-get proxy
* remap CAPS to Ctrl
* generate new ssh keys for system
* setup keypass
* setup firefox sync
