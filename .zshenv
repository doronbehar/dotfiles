#!/bin/zsh

# {{{1 `_command_exists`: Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}
# {{{1 `insert2PATH`: function to insert (in the beginning) of $PATH a directory only if it doesn't exist already.
insert2PATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If the directory exists and it doesn't exists already in $PATH
		if [[ -d "$i" ]] && ! echo $PATH | grep -q "$i"; then
			export PATH="$i"":""$PATH"
		fi
	done
}
# {{{1 `insert2MANPATH`: function to insert (in the beginning) of $MANPATH a directory only if it doesn't exist already.
insert2MANPATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If the directory exists
		if [ -d "$i" ]; then
			# If it doesn't exists already in $MANPATH
			if ! echo $MANPATH | grep -q "$i"; then
				export MANPATH="$i"":""$MANPATH"
			fi
		else
			echo \'error at: .zshenv\': you have tried to insert "$i" to MANPATH but it\'s not a directory or it doesn\'t exist
		fi
	done
}
# }}}1
# {{{1 `insert2LUA_PATH`: function to insert (in the beginning) of $LUA_PATH a directory only if it doesn't exist already.
insert2LUA_PATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If it doesn't exists already in $LUA_PATH
		if ! echo $LUA_PATH | grep -q "$i"; then
			export LUA_PATH="$i"";""$LUA_PATH"
		fi
	done
}
# }}}1

# {{{1 DOMAIN and FQDN
export DOMAIN="$(hostname -d)"
export FQDN="$(hostname -f)"

# - {{{1 PATH
insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"
insert2PATH "$HOME/.luarocks/bin"
insert2PATH "$HOME/.gem/ruby/2.4.0/bin/"
if _command_exists ccache; then
	insert2PATH "/usr/lib/ccache/bin"
fi
# - {{{1 Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
insert2PATH "$HOME/.rvm/bin"

# - {{{1 CPAN
insert2PATH "$HOME/.perl5/bin"


# - {{{1 LUA_PATH and LUA_CPATH
if _command_exists luarocks; then
	eval $(luarocks path)
fi

# - {{{1 VISUAL/EDITOR
if _command_exists nvim; then
	if [[ -z $NVIM_LISTEN_ADDRESS ]]; then
		export EDITOR="nvim"
		export VISUAL="nvim"
		export MANPAGER="$EDITOR --cmd 'let g:loaded_youcompleteme = 1' -c 'set ft=man' -"
	else
		export EDITOR="nvr"
		export VISUAL="nvr"
		export MANPAGER="$EDITOR -c 'set ft=man' -"
	fi
	export SUDO_EDITOR="env XDG_CONFIG_HOME=${HOME}/.config $EDITOR"
elif _command_exists vim; then
	export EDITOR="vim"
	export VISUAL="vim"
	export SUDO_EDITOR="env VIM=${HOME}/.vim vim"
	export MAN_PN=1 
	export MANPAGER="$EDITOR --cmd 'let g:loaded_youcompleteme = 1' -M +MANPAGER -"
else
	# taken from wiki.archlinux.org
	export MANPAGER=env\ LESS_TERMCAP_mb=$'\E[01;31m'\ LESS_TERMCAP_md=$'\E[01;38;5;74m'\ LESS_TERMCAP_me=$'\E[0m'\ LESS_TERMCAP_se=$'\E[0m'\ LESS_TERMCAP_so=$'\E[38;5;246m'\ LESS_TERMCAP_ue=$'\E[0m'\ LESS_TERMCAP_us=$'\E[04;38;5;146m'\ less
fi
export GIT_EDITOR="$VISUAL"

# - {{{1 gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'



# - {{{1 xdg
[[ -f "$HOME/.config/user-dirs.dirs" ]] && source "$HOME/.config/user-dirs.dirs"

# - {{{1 COLUMNS
export COLUMNS=

# - {{{1 local environmental variables
[[ -f "$HOME/.local/share/zsh/${TERM}/env" ]] && source "$HOME/.local/share/zsh/${TERM}/env"
[[ -f "$HOME/.local/share/zsh/${DISPLAY}/env" ]] && source "$HOME/.local/share/zsh/${DISPLAY}/env"
[[ -f "$HOME/.local/share/zsh/${VENDOR}/env" ]] && source "$HOME/.local/share/zsh/${VENDOR}/env"
[[ -f "$HOME/.local/share/zsh/${OSTYPE}/env" ]] && source "$HOME/.local/share/zsh/${OSTYPE}/env"
[[ -f "$HOME/.local/share/zsh/${HOST}/env" ]] && source "$HOME/.local/share/zsh/${HOST}/env"
[[ -f "$HOME/.local/share/zsh/${FQDN}/env" ]] && source "$HOME/.local/share/zsh/${FQDN}/env"
[[ -f "$HOME/.local/share/zsh/${DOMAIN}/env" ]] && source "$HOME/.local/share/zsh/${DOMAIN}/env"

# - {{{1
# vim:ft=zsh:foldmethod=marker
