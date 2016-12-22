#!/bin/zsh
# {{{ enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
# {{{ ls
alias ls='ls --color=auto'
alias cls='ls --color=always'
# }}}
# {{{ dir
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias cdir='dir --color=always'
alias cvdir='vdir --color=always'
# }}}
# {{{ grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cgrep='grep --color=always'
alias cfgrep='fgrep --color=always'
alias cegrep='egrep --color=always'
# }}}
# }}}

# {{{ Useful

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# {{{ ranger
# alias taken from http://superuser.com/questions/1043806/is-it-possible-to-exit-from-ranger-file-explorer-back-to-command-prompt-but:
alias cranger='ranger --choosedir=/tmp/doron.rangerdir; cd `cat /tmp/doron.rangerdir`'
alias ranger='ranger --choosedir=/tmp/doron.rangerdir'
alias cdr='cd `cat /tmp/doron.rangerdir`'
# }}}

# }}}

# {{{ *Don't forget* Aliases
# make the mv and cp commands interactive and therefor safer and verbose.
alias cp='cp -vi'
alias mv='mv -vi'
# }}}

# {{{ Shortcuts
# make git to easily print log commits with --no-pager
alias git-l='git --no-pager log'
alias trc=transmission-remote-cli
alias ..="cd .."
alias v='nvim'
alias cxclip="xclip -selection clipboard"
alias pxclip="xclip -selection primary"
alias t=task
# colored cat
alias ccat='source-highlight --failsafe --infer-lang --out-format=esc --style-file=esc.style -i'
# colored diff
alias cdiff='colordiff'
# YouTube-viewer perl application.
alias ytv='youtube-viewer'
# Show my YouTube Playlists with $YOUTUBE_CHANNEL_ID env var.
alias my-ytv='youtube-viewer -cp "$YOUTUBE_CHANNEL_ID"'
# xdg-open
alias o='xdg-open'
# extract urls from a file or stdin
alias urls="perl -ne 's#.*(https*://[^\"]*).*#\1# && print'"
# }}}

# vim:ft=zsh:foldmethod=marker
