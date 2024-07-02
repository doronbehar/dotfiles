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
	# From some reason this is set to /usr/bin/bash instead, which is not
	# found by neovim's :term
	export SHELL="$(which bash.exe)"
	# https://github.com/direnv/direnv/issues/253#issuecomment-466788426
	_direnv_hook() {
		local previous_exit_status=$?;
		eval "$(MSYS_NO_PATHCONV=1 "direnv.exe" export bash | sed 's|export PATH=|export _X_DIRENV_PATH=|g')";
		if [ -n "$_X_DIRENV_PATH" ]; then
			_X_DIRENV_PATH=$(cygpath -p "$_X_DIRENV_PATH")
			export "PATH=$_X_DIRENV_PATH"
			unset _X_DIRENV_PATH
		fi
		return $previous_exit_status;
	};
	if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
		PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND"
	fi
fi

# vim:ft=sh:foldmethod=marker
