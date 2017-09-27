#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# {{{ History
# append to the history file, don't overwrite it
shopt -s histappend
# don't put duplicate lines in the history
export HISTCONTROL="ignoredups:ignorespace"
# Keep 1000 lines of history within the shell
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.local/share/bash-history"
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# }}}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# {{{ Completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash/completion ] && ! shopt -oq posix; then
	. /etc/bash/completion
fi
if [ -f ~/.tmux/bash-completion ]; then
	source ~/.tmux/bash-completion
fi
# }}}

# vim:ft=sh:foldmethod=marker
