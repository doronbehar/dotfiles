# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias ..="cd .."
alias lsl="ls -lhFA | less"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# colored cat:
alias ccat='pygmentize -g'
# colored diff
alias cdiff='colordiff'
# script maid to load variables and put me in a certain directory
alias 'p'='setup'
# script to load all ".files" in their correct order:
alias 'load'='. ~/.bin/load'
# Show PATH
alias 'path'="echo $PATH | sed -e 's/:/\n/g'"
# an alias to grep my public IP address and insert in the clipboard
alias xip='wget http://ipinfo.io/ip -O - | xclip'
# alias for git to easily print commits with --no-pager
alias git-l='git --no-pager log'
# alias to show dotfiles only:
alias lh='ls -ld .??*'
# quartus IDE command line interface:
if [ -z "$QUARTUS_BIN" ]; then
	QUARTUS_BIN="/opt/altera/quartus/bin"
fi;
alias "altgx-diffmifgen"="$QUARTUS_BIN/altgx_diffmifgen"
alias "altgx-mifgen"="$QUARTUS_BIN/altgx_mifgen"
alias "dmf-ver"="$QUARTUS_BIN/dmf_ver"
alias "fir-netlist-writer"="$QUARTUS_BIN/fir_netlist_writer"
alias "ip-toolbench"="$QUARTUS_BIN/ip_toolbench"
alias "mega-alt-fault-injection"="$QUARTUS_BIN/mega_alt_fault_injection"
alias "mega-symc"="$QUARTUS_BIN/mega_symc"
alias "mega-symcng"="$QUARTUS_BIN/mega_symcng"
alias "pll-cmd"="$QUARTUS_BIN/pll_cmd"
alias "qt-example-app"="$QUARTUS_BIN/qt_example_app"
alias "tb2-install"="$QUARTUS_BIN/tb2_install"
alias "uniphy-mcc"="$QUARTUS_BIN/uniphy_mcc"
alias "xcvr-diffmifgen"="$QUARTUS_BIN/xcvr_diffmifgen"
