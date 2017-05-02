#!/bin/zsh

# {{{ `man` - make man with `less` be more colorfull
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

# {{{ `cdg` - cd into git repository (even if it's a submodule).
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

# {{{ `fpath` - list of paths for directories containing functions for zsh completion
fpath(){
	echo "$fpath" | sed -e 's/\ /\n/g'
}
# }}}

# {{{ `cdm` - Go to the directory the current song played by mpd is located in
cdm(){
	cd $MPD_MUSIC_DIR/"$(mpc current --format "%file%" | awk -F'/' '{for (i=1; i<=NF-1; ++i) printf $i"/"}')"
}
# }}}

# {{{ `p` - bookmark navigator
# Works like ranger's bookmarks
# Usage:
# You need to use/create a bookmarks file in `.config/ranger/bookmarks` which will looks like that:
# ```
# v:/home/doron/repos/dotfiles/.config/nvim
# O:/opt
# a:/home/doron/repos/dotfiles/.config/awesome
# x:/home/doron/repos/dotfiles/.tmux
# ```
# As for this bookmarks as an example, running `p v` for instance will bring you straight to Neovim's configuration directory.

p(){
	while read -r line; do
		if [ "$1" = "$(echo "$line" | cut -d':' -f1)" ]; then
			eval cd "$(echo "$line" | cut -d':' -f2)"
		fi
	done < ~/.config/ranger/bookmarks
}
# }}}

# {{{ **last actions** - Startx at start up only if it's on tty1 and there isn't a DISPLAY set already
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 && $USER == "doron" ]];then
	exec startx
fi
# }}}

# vim:ft=zsh:foldmethod=marker
