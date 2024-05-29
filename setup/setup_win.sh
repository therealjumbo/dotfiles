#!/bin/bash
set -eu

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

# create tmp dirs for nvim for user
mkdir -p "$USERPROFILE/.vimtmp/tmp/backupdir"
mkdir -p "$USERPROFILE/.vimtmp/tmp/swapdir"
mkdir -p "$USERPROFILE/.vimtmp/tmp/undodir"
