#!/bin/zsh

# {{{1 Default IFS
export DEFAULT_IFS="$IFS"

# {{{1 HOST - from some reason this is not exported by deafult
export HOST

# {{{1 SSH_ORIGINAL_TERM - used by my ssh configs - part of the environment that's set
export SSH_ORIGINAL_TERM="$TERM"

# {{{1 `insert2PATH`: function to insert (in the beginning) of $PATH a directory only if it doesn't exist already.
insert2PATH(){
	# Simple test to mitigate duplications
	if [[ ! $PATH =~ "$1" ]]; then
		PATH="$1"":""$PATH"
	fi
}

insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"

# {{{1 `_command_exists`: Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}

# - {{{1 VISUAL/EDITOR
if _command_exists nvim; then
	if [ -z "${NVIM_LISTEN_ADDRESS+1}" ]; then
		export EDITOR="nvim"
		export MANPAGER="$EDITOR --cmd 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' +Man!"
		# See https://github.com/neovim/neovim/issues/10808
		export MANWIDTH=999
		export GIT_EDITOR="$EDITOR"
	else
		# Only git needs to know when the editor exits
		export GIT_EDITOR="nvr --remote-silent --remote-wait"
		export EDITOR="nvr"
		export MANPAGER="$EDITOR -c 'set ft=man' -"
	fi
	export SUDO_EDITOR="env XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config} $EDITOR"
elif _command_exists vim; then
	export EDITOR="vim"
	export MAN_PN=1
	export MANPAGER="$EDITOR --remote-silent --remote-wait 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' -M +MANPAGER -"
	export GIT_EDITOR="$EDITOR"
	export SUDO_EDITOR="env VIM=${HOME}/.vim $EDITOR"
else
	# taken from wiki.archlinux.org
	export MANPAGER=env\ LESS_TERMCAP_mb=$'\E[01;31m'\ LESS_TERMCAP_md=$'\E[01;38;5;74m'\ LESS_TERMCAP_me=$'\E[0m'\ LESS_TERMCAP_se=$'\E[0m'\ LESS_TERMCAP_so=$'\E[38;5;246m'\ LESS_TERMCAP_ue=$'\E[0m'\ LESS_TERMCAP_us=$'\E[04;38;5;146m'\ less
fi
export VISUAL="$EDITOR"

# - {{{1 FZF
export FZF_DEFAULT_OPTS="--history=$HOME/.local/share/fzf/history"

# - {{{1 local environmental variables
if [[ -f "$HOME/.local/share/zsh/env/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/env/${HOST}"
fi

# - {{{1
# vim:ft=zsh:foldmethod=marker
