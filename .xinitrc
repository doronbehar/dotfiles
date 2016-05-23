#!/bin/sh

xrandr --output DP1 --mode 1280x1024 --left-of HDMI1 --output HDMI1 --mode 1680x1050
xset r rate 250 27
exec awesome
