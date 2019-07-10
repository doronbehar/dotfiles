#!/bin/sh
xset -dpms
xset s noblank
xset s off
xset r rate 250 27
export PINENTRY_USER_DATA=gtk-2
if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi
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
exec awesome
