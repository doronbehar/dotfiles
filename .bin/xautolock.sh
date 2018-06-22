#!/bin/sh
/usr/bin/xautolock \
	-time 7 \
	-locker "${HOME}/.bin/xlock.sh" \
	-corners '-+-+' \
	-notifier 'notify-send --app-name=xautolock --expire-time=10000 "xautolock will lock the computer in 5 seconds of inactivity"'
