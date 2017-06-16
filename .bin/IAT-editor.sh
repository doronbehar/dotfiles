#!/bin/sh

# Text editor invocator for The firefox addon?extension named "It's all Text"
# Available here:
# - https://github.com/docwhat/itsalltext
# - https://addons.mozilla.org/en-US/firefox/addon/its-all-text
set -eu
exec /usr/bin/urxvt -e $VISUAL "$@"
