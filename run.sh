#!/bin/bash
set -e

# ask for password upfront
sudo -v

# keep-alive; update existing sudo time stamp if set, otherwise do nothing
while true;
    do sudo -n true;
    sleep 60;
    kill -0 "$$" || exit;
done 2>/dev/null &

./install/install.sh || exit 1

./setup/setup.sh || exit 1

./dotfiles/dotfiles.sh || exit 1

./usr/usr.sh || exit 1
