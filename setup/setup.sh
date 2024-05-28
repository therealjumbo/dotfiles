#!/bin/bash
set -eu

# create tmp dirs for nvim for user
mkdir -p "$HOME/.vimtmp/tmp/backupdir"
mkdir -p "$HOME/.vimtmp/tmp/swapdir"
mkdir -p "$HOME/.vimtmp/tmp/undodir"

if [ "$OS" != "Windows_NT" ]; then
  # create tmp dirs for nvim for root
  sudo mkdir -p "/root/.vimtmp/tmp/backupdir"
  sudo mkdir -p "/root/.vimtmp/tmp/swapdir"
  sudo mkdir -p "/root/.vimtmp/tmp/undodir"
fi

if [ "$NATIVE_LINUX" = "true" ]; then
  sudo groupadd docker || true
  sudo groupadd wireshark || true
  sudo usermod -aG docker "$(whoami)"
  sudo usermod -aG wireshark "$(whoami)"
  sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

  # enable the avahi ssh service, if it doesn't yet exist
  # the service files cannot be absolute symlinks since avahi runs in a chroot.
  # Relative symlinks can be confusing, so just cp the file instead.
  [ -f /etc/avahi/services/ssh.service ] || sudo cp -Lpf \
      /usr/share/doc/avahi-daemon/examples/ssh.service /etc/avahi/services
fi

if [ "$OS" != "Windows_NT" ]; then
  sudo groupadd fuse || true
  sudo usermod -aG fuse "$(whoami)"

  # only set zsh as the default shell if not already set
  if ! grep -qF "zsh" <(echo "$SHELL"); then
      echo "Enter $(whoami)'s password for chsh"
      chsh -s "$(command -v zsh)"
  fi

  # create main zsh function dir
  mkdir -p "$HOME/.zfunc"
  # add rustup completions to zsh
  "$HOME/.cargo/bin/rustup" completions zsh > ~/.zfunc/_rustup
fi
