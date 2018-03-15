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

# - {{{1 _CURRENT_SHELL_ENVIRONMENT
export _CURRENT_SHELL_ENVIRONMENT="${TERM}-${DISPLAY:-$VENDOR-$OSTYPE}"
# - {{{1 PATH
insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"
insert2PATH "$HOME/.luarocks/bin"
insert2PATH "$HOME/.gem/ruby/2.4.0/bin/"
if _command_exists ccache; then
	insert2PATH "/usr/lib/ccache/bin"
fi
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
insert2PATH "$HOME/.rvm/bin"

# - {{{1 CPAN
insert2PATH "$HOME/.perl5/bin"

# - {{{1 MANPATH
if [ -d "$HOME/.virtualenv" ]; then
	insert2MANPATH "$(find $HOME/.virtualenv -type d -name man)"
fi

# - {{{1 VISUAL/EDITOR
if _command_exists nvim; then
	export EDITOR="nvim"
	export VISUAL="nvim"
	if _command_exists nvr; then
		export NVIM_LISTEN_ADDRESS="${XDG_RUNTIME_DIR}/nvim.socket"
	fi
elif _command_exists vim; then
	export EDITOR="vim"
	export VISUAL="vim"
fi

# - {{{1 gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# - {{{1 local environmental variables
[[ -f "$HOME/.local/share/zsh/${_CURRENT_SHELL_ENVIRONMENT}-${HOST}/env" ]] && source "$HOME/.local/share/zsh/${_CURRENT_SHELL_ENVIRONMENT}-${HOST}/env"

# - {{{1 MPD
[[ -f /etc/mpd.conf ]] && export MPD_MUSIC_DIR="$(awk -F'"' '{if ($0 ~ /music_dir/) print $2}' /etc/mpd.conf)"

# - {{{1 xdg
[[ -f "$HOME/.config/user-dirs.dirs" ]] && source "$HOME/.config/user-dirs.dirs"

# - {{{1 COLUMNS
export COLUMNS=
# - {{{1
# vim:ft=zsh:foldmethod=marker
