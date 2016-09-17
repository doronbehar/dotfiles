#!/bin/zsh
# function to append $PATH a directory only if it doesn't exist already.
# On my machine at home it overrides almost the same function. The difference
# is that the system wide function appends the argument in the beginning and
# not at the end of $PATH - It makes sense because this way a user has the
# choice of using custom scripts with the same name as some that exist on the
# system. When the interpretor reads $PATH it searches through the 1st
# directories 1st. So scripts in ~/.bin will be used over /bin for example.
add2PATH(){
	if ! echo $PATH | grep -q "$1"; then
		PATH="$1"":""$PATH"
	fi
}
if [ -d "$HOME/bin" ]; then
	add2PATH "$HOME/bin"
fi
# Include user's private bin directory if it exists
if [ -d "$HOME/.bin" ]; then
	add2PATH "$HOME/.bin"
fi
if [ -d "$HOME/.local/bin" ]; then
	add2PATH "$HOME/.local/bin"
fi

# Program's settings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LESS="-X -x4 -r -i"
export LESSHISTFILE="$HOME/.local/share/less-history"

# Check If a command is installed locally in /usr/local/bin/ or ~/.local/bin/ and not /usr/bin/ for example.
_command_is_local(){
	if type "$1" | grep -q local; then
		return 0
	else
		return 1
	fi
}
# Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}
if _command_exists nvim; then
	export EDITOR="nvim"
	export VISUAL="nvim"
	if _command_is_local; then
		export VIMRUNTIME="/usr/local/share/nvim/runtime"
	fi
elif _command_exists vim; then
	export EDITOR="vim"
fi
export PAGER="less"

# Shell settings
# - Keep 1000 lines of history within the shell and save it to ~/.sh/history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.local/share/shells-history"
# - don't put duplicate lines in the history:
HISTCONTROL="ignoredups:ignorespace"

# Genreal settings
# - I always forget this one before I parse commands outputs etc:
IFS=$'\n'
# - Source xdg settings from .config/user-dirs.dirs
source "$HOME/.config/user-dirs.dirs"
