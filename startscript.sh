#!/bin/sh

/home/shastro/scripts/setbg
if ! pgrep -f "picom" &> /dev/null 2>&1; then
   picom &>/dev/null &
fi
# /home/shastro/dwm-bar/dwm_bar.sh &>/dev/null &
