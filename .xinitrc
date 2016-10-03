#!/bin/sh
xset -dpms
xset s noblank
xset s off
xset r rate 250 27
[ -f ~/.xprofile ] && source ~/.xprofile
exec awesome
