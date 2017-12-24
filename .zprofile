#!/bin/zsh
# {{{1 enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	# ls
	alias ls='ls --color=auto'
	alias cls='ls --color=always'
	# dir
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias cdir='dir --color=always'
	alias cvdir='vdir --color=always'
	# grep
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias cgrep='grep --color=always'
	alias cfgrep='fgrep --color=always'
	alias cegrep='egrep --color=always'
	# diff
	alias diff='diff --color=auto'
	alias cdiff='diff --color=always'
	# always colored pacman and yay
	alias cpacman='pacman --color=always'
	# always colored ack
	alias cack='ack --color=always'
fi

# {{{1 Other aliases
# taskwarrior
alias tw=task
# YouTube-viewer perl application.
alias ytv='youtube-viewer'
# xdg-open
alias o='xdg-open'
# ranger with cd into last directory
alias cranger='ranger --choosedir=/tmp/doron.rangerdir; cd `cat /tmp/doron.rangerdir`'
alias ranger='ranger --choosedir=/tmp/doron.rangerdir'
alias cdr='cd "$(cat /tmp/doron.rangerdir)"'
# xclip
alias cxclip="xclip -selection clipboard"
alias pxclip="xclip -selection primary"
# colored cat: src-highlite
alias ccat='source-highlight --failsafe --infer-lang --out-format=esc --style-file=esc.style -i'
# systemctl poweroff/reboot
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
# lua interpreter with luarocks loaded in package.path
alias luar='lua -e pcall\(require,\"luarocks.loader\"\) -i'
# visual/editor with GhostStart for quick launch
alias gvi="${VISUAL} +GhostStart"
# shortcut for launching GNU Octave with --no-gui
alias oct='octave --no-gui'

# {{{1 `man` - make man with `less` be more colorfull
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

# {{{1 `cdg` - cd into git repository (even if it's a submodule).
cdg(){
	if [ -d .git ]; then
		cd .git
	elif [ -f .git ]; then
		cd $(sed 's/gitdir: //g' .git)
	else
		echo this is not a git repository - No .git file or directory found here
	fi
}

# {{{1 `fpath` - list of paths for directories containing functions for zsh completion
fpath(){
	echo "$fpath" | sed -e 's/\ /\n/g'
}

# {{{1 `cdm` - Go to the directory the current song played by mpd is located in
cdm(){
	cd $MPD_MUSIC_DIR/"$(mpc current --format "%file%" | awk -F'/' '{for (i=1; i<=NF-1; ++i) printf $i"/"}')"
}

# {{{1 `t` - Taskwarrior shortcut with evaluation of overriding runtime variables using environmental variables.
function t() {
	if [[ -z "$TASK_OVERRIDE" ]]; then
		task "$@"
	else
		eval task $TASK_OVERRIDE "$@"
	fi
}

# {{{1 `p` - bookmark navigator
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

# vim:ft=zsh:foldmethod=marker
