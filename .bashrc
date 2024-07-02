#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend
# don't put duplicate lines in the history
export HISTCONTROL="ignoredups:ignorespace"
# Keep 1000 lines of history within the shell
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.local/share/bash-history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ -z "$DOTFILES_DIR" ]; then
	DOTFILES_DIR="$HOME"
fi

source "$DOTFILES_DIR/.zshenv"
# shell common functions and aliases
for i in $DOTFILES_DIR/.shell/*; do
	source "$i"
done
unset i
source "$DOTFILES_DIR/.zlogin"

if [ "$OSTYPE" == "msys" ]; then
	export XDG_CONFIG_HOME=$HOME/AppData/Local
fi

eval "$(direnv hook bash)"

# vim:ft=sh:foldmethod=marker
