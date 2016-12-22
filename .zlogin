#!/bin/zsh

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

# {{{ Go to the directory the current song played by mpd is located in
cdm(){
	cd $MPD_MUSIC_DIR/"$(mpc current --format "%file%" | awk -F'/' '{for (i=1; i<=NF-1; ++i) printf $i"/"}')"
}
# }}}

# {{{ tls
# function for todo.txt to change from time to time the directory the `todo.txt` and `done.txt` files are located.
tls(){
	if [ ! -d "$DROPBOX_TODO_DIR" ]; then
		echo "tls needs variable \$DROPBOX_TODO_DIR to be defined.
		\$TODO_DIR was not set because either \$DROPBOX_TODO_DIR is not set or could be the directory \$DROPBOX_TODO_DIR dosn\'t exist.">&1
		return 1
	else
		if [ -z "$1" ]; then
			echo "\$TODO_DIR is set as $TODO_DIR"
			return 0
		elif [[ "$1" == "-h" ]]; then
			cat <<-ENDUSAGE
				Usage:

					tls -h          displays this help message
					tls -l          displays all the subfolders inside \$DROPBOX_TODO_DIR
					tls             (without any arguments) displays the current \$TODO_DIR
					tls <dir>       exports the necessary variables for todo.sh to work in the selected dir
					tls <dir> -q    does the same as the above but doesn\'t print what it does
			ENDUSAGE
		elif [[ "$1" == "-l" ]]; then
			find "$DROPBOX_TODO_DIR" -maxdepth 1 -mindepth 1 -type d -printf '%P\n'
		elif [ ! -d "$DROPBOX_TODO_DIR"/"$1" ]; then
			echo "$1"/ dosn\'t exist inside "$DROPBOX_TODO_DIR", tls failed.>&1
			return 1
		else
			export TODO_DIR="$DROPBOX_TODO_DIR"/"$1"
			export TODO_FILE="$DROPBOX_TODO_DIR"/"$1"/todo.txt
			export DONE_FILE="$DROPBOX_TODO_DIR"/"$1"/done.txt
			export REPORT_FILE="$DROPBOX_TODO_DIR"/"$1"/report.txt
			[[ ! "$@" =~ "-q" ]] && echo \$TODO_DIR was set as "$DROPBOX_TODO_DIR"/"$1"
			return 0
		fi
	fi
}

tls general -q
# }}}

# {{{ `p` bookmark navigator
# Works like ranger's bookmarks manager
p(){
	while read -r line; do
		if [ "$1" = "$(echo "$line" | cut -d':' -f1)" ]; then
			eval cd "$(echo "$line" | cut -d':' -f2)"
			if [ -f makefile ]; then
				eval export $(awk '{ if ($0 ~ /^[a-zA-Z_]*=/) {gsub(/shell /, "", $0 ); print}}' makefile)
			fi
			ls --color=auto -lhA
			if [ -e .git ]; then
				git status
			fi
		fi
	done < ~/.config/ranger/bookmarks
}
# }}}

# {{{ Startx in every start up only if it's on tty1 and there isn't a DISPLAY set
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && $USER == "doron" ]] && exec startx
# }}}

# vim:ft=zsh:foldmethod=marker
