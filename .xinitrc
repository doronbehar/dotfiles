#!/bin/sh
xset -dpms
xset s noblank
xset s off
xset r rate 250 27
[ -f /etc/X11/xinit/xinitrc.d/50-systemd-user.sh ] && . /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
export HOST="$(hostname)"
export FQDN="$(hostname -f)"
export DOMAIN="$(hostname -d)"
# - local x profiles
if [[ -f "$HOME/.local/share/xorg/${DISPLAY}" ]]; then
	source "$HOME/.local/share/xorg/${DISPLAY}"
fi
if [[ -f "$HOME/.local/share/xorg/${VENDOR}" ]]; then
	source "$HOME/.local/share/xorg/${VENDOR}"
fi
if [[ -f "$HOME/.local/share/xorg/${OSTYPE}" ]]; then
	source "$HOME/.local/share/xorg/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/xorg/${HOST}" ]]; then
	source "$HOME/.local/share/xorg/${HOST}"
fi
if [[ -f "$HOME/.local/share/xorg/${FQDN}" ]]; then
	source "$HOME/.local/share/xorg/${FQDN}"
fi
if [[ -f "$HOME/.local/share/xorg/${DOMAIN}" ]]; then
	source "$HOME/.local/share/xorg/${DOMAIN}"
fi
awesome && killall redshift
exit 0
