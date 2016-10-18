#!/bin/zsh
# {{{ quartus
# The function makes it easier to call Quartus' IDE executables
# Explanation:
# The normal "QUIARTUS_BIN" directory is full of executables like:
# 1. quartus_sh
# 2. quartus_eda
# 3. quartus_drc
# So the point is that it's hard and annoying to type the underscore "_"
# every time you want to use these executables. This function is supposed
# to help you so you can type for example `quartus sh` and it will run quarts_sh
# from that directory.
# As well, it automatically puts the --64 argument to each one of these executables
# so you will always stay with the 64 function
quartus(){
	if [ -z "$QUARTUS_BIN" ]; then
		if [ -d "/opt/altera/quartus/bin" ]; then
			QUARTUS_BIN="/opt/altera/quartus/bin"
		else
			echo "Error: check the environmental variable \"QUARTUS_BIN\"."
			echo "       It should be a path to where you quartus\' executables."
			echo "       It can be for example: /opt/altera/quartus/bin."
			echo "           **Note**: Don\'t put an extra / at the end of the path."
			return 1
		fi
	fi
	if [ "$1" = "gui" ] || [ "$1" = "--gui" ] || [ "$1" = "-g" ]; then
		command $QUARTUS_BIN/quartus --64bit "${@:2}"
	elif [ "$1" = "" ]; then
		echo "Usage:\n--gui | -g | gui for the gui"
		echo `ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2`;
	else
		#for EXTENSION in $(ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2); do
		#	if [ "$1" = "$EXTENSION" ]; then
		#		command $QUARTUS_BIN/quartus_$EXTENSION --64bit "${@:2}"
		#	fi
		#done
		command $QUARTUS_BIN/quartus_"$1" --64bit "${@:2}"
	fi
}
# }}}

# {{{ make man with `less` be more colorfull
# taken from wiki.archlinux.org
man(){
	env LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[01;38;5;74m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[38;5;246m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[04;38;5;146m' \
	man "$@"
}
# }}}

# {{{ cd into git repository (even if it's a submodule).
cdg(){
	if [ -d .git ]; then
		cd .git
	elif [ -f .git ]; then
		cd $(sed 's/gitdir: //g' .git)
	else
		echo this is not a git repository - No .git file or directory found here
	fi
}
# }}}

# {{{ Show fpath - list of paths for directories containing functions for zsh completion
fpath(){
	echo "$fpath" | sed -e 's/\ /\n/g'
}
# }}}

# vim:ft=zsh:foldmethod=marker
