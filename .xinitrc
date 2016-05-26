#!/bin/sh

sleep 15 && xrandr --output DP1 --mode 1280x1024 --right-of HDMI1 --output HDMI1 --mode 1680x1050 &
/opt/urserver/urserver-start --no-manager --no-notify &
sleep 15 && xset -dpms && xset s noblank && xset s off &
sleep 15 && xset r rate 250 27 &
exec awesome
