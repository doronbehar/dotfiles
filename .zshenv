#!/bin/zsh

# {{{ `_command_is_local`: Checks If a command is installed locally in /usr/local/bin/ or ~/.local/bin/ and not /usr/bin/ for example.
_command_is_local(){
	if type "$1" | grep -q local; then
		return 0
	else
		return 1
	fi
}
# }}}
# {{{ `_command_exists`: Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}
# }}}
# {{{ `insert2PATH`: function to insert (in the beginning) $PATH a directory only if it doesn't exist already.
insert2PATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If the directory exists
		if [ -d "$i" ]; then
			# If it doesn't exists already in $PATH
			if ! echo $PATH | grep -q "$i"; then
				export PATH="$i"":""$PATH"
			fi
		fi
	done
}
# }}}

# - PATH
insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"
insert2PATH "$HOME/bin"
if _command_exists gem; then
	insert2PATH "$(find $HOME/.gem/ruby -maxdepth 1 -mindepth 1 -type d | sort -rn | head -n1)/bin"
fi
# - VISUAL/EDITOR
if _command_exists nvim; then
	export EDITOR="nvim"
	export VISUAL="nvim"
	if _command_is_local nvim; then
		export VIMRUNTIME="/usr/local/share/nvim/runtime"
	else
		export VIMRUNTIME="/usr/share/nvim/runtime"
	fi
elif _command_exists vim; then
	export EDITOR="vim"
	export VISUAL="vim"
else
	echo It seems like you don\'t have Vim nor Neovim in your PATH - Bad situation, make sure "\$HOME/.local/share/zsh" contains the right variables.
	if [ -f "$HOME/.local/share/zsh" ]; then
		source "$HOME/.local/share/zsh"
	else
		echo Oh, It seems like you really need a "\$HOME/.local/share/zsh" and it doesn\'t even exists.. >2
	fi
fi
# - PAGER
if _command_exists less; then
	export PAGER="less"
	export LESS="-X -x4 -r -i"
	export LESSHISTFILE="$HOME/.local/share/less-history"
fi
# - gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# - ranger: make it not load default rc.conf from /etc so startup will be faster
export RANGER_LOAD_DEFAULT_RC="FALSE"
# - translate-shell
export HOME_LANG="he"
export TARGET_LANG="he"
# - MPD music directory:
export MPD_MUSIC_DIR="$(awk -F'"' '{if ($0 ~ /music_dir/) print $2}' /etc/mpd.conf)"
# - YouTube Channel ID for youtube-viewer (perl application)
export YOUTUBE_CHANNEL_ID="UCRymTwOOJEx-BEqfQRp5T5Q"
# - ssh
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# - I always forget this one before I parse commands outputs etc:
export IFS=$'\n'
# - xdg browser
export BROWSER="google-chrome-stable"
# - xdg settings
source "$HOME/.config/user-dirs.dirs"
# - GO
export GOPATH="$HOME/.go"
insert2PATH "$GOPATH/bin"
# - taskwarrior
export TASKDDATA="/var/lib/taskd"

# vim:ft=zsh:foldmethod=marker
