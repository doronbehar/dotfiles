#!/bin/zsh
# {{{ Looks
# syntax highlighting
source ~/.zsh-syntax-highlighting/plugin
fpath=(~/.zsh-prompts $fpath)
autoload -Uz colors && colors
autoload promptinit && promptinit
setopt promptsubst
prompt my
# }}}

# {{{ Options.
setopt HIST_IGNORE_DUPS			# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS		# Delete old recorded entry if new entry is a duplicate.
setopt SHARE_HISTORY			# Share history between all sessions.
setopt HIST_IGNORE_SPACE		# Don't record an entry starting with a space.
setopt EXTENDED_HISTORY			# Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY		# Write to the history file immediately, not when the shell exits.
setopt HIST_SAVE_NO_DUPS		# Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS		# Remove superfluous blanks before recording entry.
# }}}

# {{{ Bindings
bindkey -v
# The time lapse between <Esc> and changing to insert mode.
export KEYTIMEOUT=0
# Word movement just like in my vim config.
bindkey -a e vi-forward-word-end
bindkey -a w vi-backward-word
bindkey -a E vi-forward-blank-word-end
bindkey -a W vi-backward-blank-word
bindkey -a ge vi-forward-word
bindkey -a gw vi-backward-word-end
bindkey -a gE vi-forward-blank-word
bindkey -a gW vi-backward-blank-word-end
# }}}

# {{{ Use modern completion system.

# zsh-completions by zsh-users
fpath=(~/.zsh-completions/src $fpath)

# Initialize
autoload -Uz compinit
compinit

# {{{ zstyle
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# }}}

# {{{ Command failure
if [ -f /etc/zsh_command_not_found ]; then
	source /etc/zsh_command_not_found
elif [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Correction of previous command.
eval "$(thefuck --alias)"
# You can use whatever you want as an alias, like for Mondays
eval "$(thefuck --alias FUCK)"
# }}}

# changing to previous directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# }}}

# {{{ Launch if not already running.
# - ssh-agent if not running already.
if ! ps x | grep -v grep | grep -q ssh-agent; then
	eval "$(ssh-agent -s)"
fi
# - Startx in every start up only if it's on tty1.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && $USER == "doron" ]] && exec startx
# }}}

# vim:ft=zsh:foldmethod=marker
