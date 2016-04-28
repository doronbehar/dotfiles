# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash/completion ] && ! shopt -oq posix; then
    . /etc/bash/completion
fi

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
POWERLINE_NO_SHELL_ABOVE=1
powerline-daemon -q
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
	. /usr/share/powerline/bindings/bash/powerline.sh
elif [ -f ~/.local/share/powerline/bindings/bash/powerline.sh ]; then
	. ~/.local/share/powerline/bindings/bash/powerline.sh
elif [ -f /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ]; then
	. /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
else
	echo "you don't seem to have powerline installed, check your ~/.zshrc and add the correct path to the bindings in ~/.zshrc and ~/.bashrc"
fi
# function that can't be defined this way written in zsh:
=(){
	awk "BEGIN{ print $* }"
}

export QSYS_ROOTDIR="/opt/altera/quartus/sopc_builder/bin"

export ALTERAOCLSDKROOT="/opt/altera/hld"
