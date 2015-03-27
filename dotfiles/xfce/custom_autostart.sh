#!/bin/bash
# my customizations to xfce to be run once at login

# remap caps lock to escape
xmodmap -e "clear Lock"
xmodmap -e "keysym Caps_Lock = Escape"
