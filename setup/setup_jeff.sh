#!/bin/bash
echo "$0 is executing"

git config --global user.email "jlzignego@gmail.com"
git config --global user.name "Jeff Zignego"
git config --global core.editor vim

sudo usermod -aG docker jeff

echo "$0 is exiting"
