#!/bin/bash
echo "$0 is executing"

xmodmap -e "clear Lock"
xmodmap -e "keysym Caps_Lock = Escape"

echo "$0 is exiting"
exit
