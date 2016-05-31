#!/bin/sh

/opt/urserver/urserver-start --no-manager --no-notify &
sleep 5 && xset -dpms && xset s noblank && xset s off &
sleep 5 && xset r rate 250 27 &
exec awesome
