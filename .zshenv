#!/bin/zsh

# {{{1 Default IFS
export DEFAULT_IFS="$IFS"

# {{{1 HOST - from some reason this is not exported by deafult
export HOST

# {{{1 `insert2PATH`: function to insert (in the beginning) of $PATH a directory only if it doesn't exist already.
insert2PATH(){
	# Simple test to mitigate duplications
	if [[ ! $PATH =~ "$1" ]]; then
		PATH="$1"":""$PATH"
	fi
}

insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"
insert2PATH "$HOME/.luarocks/bin"
insert2PATH "$HOME/.perl5/bin"
insert2PATH "$HOME/.yarn/bin"
insert2PATH "$HOME/.config/yarn/global/node_modules/.bin"

# - {{{1 Guix
if [[ ! -z "${GUIX_ENABLE+1}" && ! "$PATH" =~ "guix" ]]; then
	for i in ~/.guix-profile ~/.config/guix/current ; do
		GUIX_PROFILE="$i"
		. "$i"/etc/profile
	done
fi

# {{{1 `_command_exists`: Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}

# - {{{1 VISUAL/EDITOR
if _command_exists nvim; then
	if [ -z "${NVIM_LISTEN_ADDRESS+1}" ]; then
		export EDITOR="nvim"
		export MANPAGER="$EDITOR --cmd 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' -c 'set ft=man' -"
		export MANWIDTH=999
		export GIT_EDITOR="$EDITOR"
	else
		# Only git needs to know when the editor exits
		export GIT_EDITOR="nvr --remote-silent --remote-wait"
		export EDITOR="nvr"
		export MANPAGER="$EDITOR -c 'set ft=man' -"
		export GIT_EDITOR="$EDITOR"
	fi
elif _command_exists vim; then
	export EDITOR="vim"
	export MAN_PN=1
	export MANPAGER="$EDITOR --remote-silent --remote-wait 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' -M +MANPAGER -"
	export GIT_EDITOR="$EDITOR"
else
	# taken from wiki.archlinux.org
	export MANPAGER=env\ LESS_TERMCAP_mb=$'\E[01;31m'\ LESS_TERMCAP_md=$'\E[01;38;5;74m'\ LESS_TERMCAP_me=$'\E[0m'\ LESS_TERMCAP_se=$'\E[0m'\ LESS_TERMCAP_so=$'\E[38;5;246m'\ LESS_TERMCAP_ue=$'\E[0m'\ LESS_TERMCAP_us=$'\E[04;38;5;146m'\ less
fi
export VISUAL="$EDITOR"

# - {{{1 Luarocks paths
if [[ -z "${LUA_PATH+1}" && -z "${LUA_CPATH+1}" ]] && _command_exists luarocks; then
	eval $(luarocks path --no-bin)
fi

# GnuPG
export PINENTRY_USER_DATA=tty

# - {{{1 local environmental variables
if [[ -f "$HOME/.local/share/zsh/env/${TERM}" ]]; then
	source "$HOME/.local/share/zsh/env/${TERM}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${VENDOR}" ]]; then
	source "$HOME/.local/share/zsh/env/${VENDOR}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${OSTYPE}" ]]; then
	source "$HOME/.local/share/zsh/env/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/env/${HOST}"
fi

# - {{{1
# vim:ft=zsh:foldmethod=marker
