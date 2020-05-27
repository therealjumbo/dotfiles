#!/bin/bash
set -e

# create tmp dirs for nvim
mkdir -p "$HOME/.vimtmp/tmp/backupdir"
mkdir -p "$HOME/.vimtmp/tmp/swapdir"
mkdir -p "$HOME/.vimtmp/tmp/undodir"

if [ "$NATIVE_LINUX" = "true" ]; then
  sudo groupadd docker || true
  sudo groupadd wireshark || true
  sudo usermod -aG docker "$(whoami)"
  sudo usermod -aG wireshark "$(whoami)"
  sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
fi

sudo groupadd fuse || true
sudo usermod -aG fuse "$(whoami)"

# set zsh as the default shell
echo "Enter $(whoami)'s password for chsh"
chsh -s "$(command -v zsh)"

# create main zsh function dir
mkdir -p "$HOME/.zfunc"
# add rustup completions to zsh
"$HOME/.cargo/bin/rustup" completions zsh > ~/.zfunc/_rustup

# create my GOPATH and github username subpath
mkdir -p "$HOME/proj/go/src/github.com/therealjumbo"

if [ "$NATIVE_LINUX" = "true" ]; then
  # enable the avahi ssh service, if it doesn't yet exist
  # the service files cannot be absolute symlinks since avahi runs in a chroot.
  # Relative symlinks can be confusing, so just cp the file instead.
  [ -f /etc/avahi/services/ssh.service ] || sudo cp -Lpf \
      /usr/share/doc/avahi-daemon/examples/ssh.service /etc/avahi/services
fi
