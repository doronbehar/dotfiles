#!/bin/sh
xset -dpms
xset s noblank
xset s off
xset r rate 250 27
[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
/usr/bin/gkeyring --unlock --password="$(/usr/bin/env PINENTRY_USER_DATA= /usr/bin/pass software/desktop/seahorse)"
export HOST="$(hostname)"
export FQDN="$(hostname -f)"
export DOMAIN="$(hostname -d)"
# - local x profiles
[[ -f "$HOME/.local/share/xorg/${DISPLAY}" ]] && source "$HOME/.local/share/xorg/${DISPLAY}"
[[ -f "$HOME/.local/share/xorg/${VENDOR}" ]] && source "$HOME/.local/share/xorg/${VENDOR}"
[[ -f "$HOME/.local/share/xorg/${OSTYPE}" ]] && source "$HOME/.local/share/xorg/${OSTYPE}"
[[ -f "$HOME/.local/share/xorg/${HOST}" ]] && source "$HOME/.local/share/xorg/${HOST}"
[[ -f "$HOME/.local/share/xorg/${FQDN}" ]] && source "$HOME/.local/share/xorg/${FQDN}"
[[ -f "$HOME/.local/share/xorg/${DOMAIN}" ]] && source "$HOME/.local/share/xorg/${DOMAIN}"
awesome && killall redshift
exit 0
