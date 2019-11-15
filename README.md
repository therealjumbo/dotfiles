# dotfiles
This repository includes all of my current custom dotfiles and setup/install
scripts. The included `run.sh` script runs the other scripts that install a
bunch of packages, run any setup instructions, and symlink the dotfiles in this
repo to the appropriate location.

## Supported OS's
* Debian 10 buster

## Pre-reqs
* manually add contrib and non-free to `/etc/apt/sources.list` see the
  [doc](https://wiki.debian.org/SourcesList)

## Install
``` bash
git clone https://github.com:therealjumbo/dotfiles.git
./dotfiles/run.sh
```

## Explanation
1. `./run.sh` should be the script that the user runs normally, although the
   other scripts can be run independently.

2. The `./install/install.sh` script is run. This script installs software
   packages.

3. The `./setup/setup.sh` script is run. This script runs setup commands that do
   not involve installing software or symlinking dotfiles.

4. The `./dotfiles/dotfiles.sh` script is run. This script symlinks the dotfiles
   inside this repo to the appropriate location in the home directory.

5. The `./usr/usr.sh` script is run. Each file in `./usr/bin/` is symlinked into
   `/usr/local/bin/`.

6. In order for the default shell change to take effect, you must logout and log
   back in once the scripts are finished.


## Notes
* this script enables automatic security updates, you probably want to disable
  the if you are going to use 'unstable'

## Manual setup items
* create mnt-foo.mount and mnt-foo.automount files for additional disks and then
  `systemctl enable mnt-foo.automount`
* setup system proxy (edit `/etc/environment`)
* setup apt-get proxy (edit `/etc/apt/apt.conf.d/02proxy`)
* configure monospace font
* generate new ssh keys for system
* setup keypass
* setup firefox sync
* change firefox profile to $HOME/.mozilla/firefox/profile.default
* install intel-microcode or amd-microcode, depending
* intall wifi firmware needed, see `apt-cache search firmware- | grep ^firmware`
