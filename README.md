# dotfiles
This repository includes all of my current custom dotfiles and setup/install
scripts. The included `run.sh` script runs the other scripts that install a
bunch of packages, run any setup instructions, and symlink the dotfiles in this
repo to the appropriate location.

## Supported OS's
* Debian 10 buster
* Windows 10/11

## Pre-reqs
* Debian:
    - install git
    - manually add contrib and non-free to `/etc/apt/sources.list` see the
  [doc](https://wiki.debian.org/SourcesList)
* Windows 10/11
    - enable symlinks for this account see [here](https://blogs.windows.com/windowsdeveloper/2016/12/02/symlinks-windows-10/)
    - install [winget](https://github.com/microsoft/winget-cli/releases/)

## Run

* Linux
``` bash
mkdir -p ~/projects/therealjumbo
cd ~/projects/therealjumbo
git clone https://github.com:therealjumbo/dotfiles.git
./dotfiles/run.sh
```

* Windows
In a powershell admin console:
```
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
winget install --exact --source winget --scope Machine --accept-package-agreements --id Git.Git
New-Item -ItemType Directory -Force -Path $USERPROFILE\projects\therealjumbo
Set-Location -Path $USERPROFILE\projects\therealjumbo
git clone https://github.com:therealjumbo/dotfiles.git
.\dotfiles\run.ps1
```

## Explanation
1. `./run.[sh|ps1]` should be the script that the user runs normally, although the
   other scripts can be run independently.

2. The `./install/install.[sh|ps1]` script is run. This script installs software
   packages.

3. The `./setup/setup.[sh|ps1]` script is run. This script runs setup commands that do
   not involve installing software or symlinking dotfiles.

4. The `./dotfiles/dotfiles.[sh|ps1]` script is run. This script symlinks the dotfiles
   inside this repo to the appropriate location in the home directory.

5. The `./usr/usr.[sh|ps1]` script is run. Each file in `./usr/bin/` is symlinked into
   `/usr/local/bin/`.

6. In order for the default shell change to take effect, you must logout and log
   back in once the scripts are finished.


## Notes
* On Debian, this script enables automatic security updates, you probably want
  to disable that if you are going to use debian 'unstable'

## Manual setup items
* create mnt-foo.mount and mnt-foo.automount files for additional disks and then
  `systemctl enable mnt-foo.automount`
* setup system proxy (edit `/etc/environment`)
* setup apt-get proxy (edit `/etc/apt/apt.conf.d/02proxy`)
* generate new ssh keys for system
* setup keypass
* setup firefox sync
* change firefox `about:config`
  `toolkit.legacyUserProfileCustomizations.stylesheets` setting to `true` 
    - change firefox profile to `$HOME/.mozilla/firefox/profile.default`
    - or copy `dotfiles/dotfiles/firefox/.mozilla/firefox/profile.default/chrome/userChrome.css` to the root default profile directory, in new folder `chrome`
* install intel-microcode or amd-microcode, depending
* intall wifi firmware needed, see `apt-cache search firmware- | grep ^firmware`
