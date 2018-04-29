#!/bin/bash
set -e

# symlink user made scripts to /usr/local/bin so they are available on the PATH
sudo stow --target=/usr/local/bin bin
