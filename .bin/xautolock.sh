#!/bin/sh
/usr/bin/xautolock \
	-time 7 \
	-locker "${HOME}/.bin/xlock.sh" \
	-corners '-+-+' \
	-notify '10' \
	-notifier 'notify-send --app-name=xautolock --expire-time=10000 "xautolock will lock the computer in 10 seconds of inactivity"'
