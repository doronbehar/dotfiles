#!/bin/sh
xset -dpms
xset s noblank
xset s off
xset r rate 250 27
[ -f ~/.xprofile ] && source ~/.xprofile
[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
/usr/bin/gkeyring --unlock --password="$(/usr/bin/env PINENTRY_USER_DATA= /usr/bin/pass software/desktop/seahorse)"
awesome && killall redshift
exit 0
