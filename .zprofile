# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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
alias ccat='pygmentize -g'
alias cdiff='colordiff'
alias 'p'='. ~/.bin/setup'
alias 'load'='. ~/.bin/load'
# an alias to grep my public IP address and insert in the clipboard
alias xip='wget http://ipinfo.io/ip -O - | xclip'
# alias for git to easily print commits with --no-pager
alias git-l='git --no-pager log'
# alias to show dotfiles only:
alias lh='ls -ld .??*'
# quartus IDE command line interface:
alias "altgx-diffmifgen"='/opt/altera.15.1/quartus/bin/altgx_diffmifgen'
alias "altgx-mifgen"='/opt/altera.15.1/quartus/bin/altgx_mifgen'
alias "dmf-ver"='/opt/altera.15.1/quartus/bin/dmf_ver'
alias "fir-netlist-writer"='/opt/altera.15.1/quartus/bin/fir_netlist_writer'
alias "ip-toolbench"='/opt/altera.15.1/quartus/bin/ip_toolbench'
alias "mega-alt-fault-injection"='/opt/altera.15.1/quartus/bin/mega_alt_fault_injection'
alias "mega-symc"='/opt/altera.15.1/quartus/bin/mega_symc'
alias "mega-symcng"='/opt/altera.15.1/quartus/bin/mega_symcng'
alias "pll-cmd"='/opt/altera.15.1/quartus/bin/pll_cmd'
alias "qt-example-app"='/opt/altera.15.1/quartus/bin/qt_example_app'
alias "tb2-install"='/opt/altera.15.1/quartus/bin/tb2_install'
alias "uniphy-mcc"='/opt/altera.15.1/quartus/bin/uniphy_mcc'
alias "xcvr-diffmifgen"='/opt/altera.15.1/quartus/bin/xcvr_diffmifgen'
