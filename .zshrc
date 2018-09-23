#!/bin/zsh

# {{{ Completion.
# Completions by zsh-users
fpath=(~/.zsh-completions/src $fpath)
fpath=(~/.zsh-collected-completions/src $fpath)
fpath=(~/.zsh-local-completions $fpath)
fpath=(~/.zsh-untracked-completions $fpath)
fpath=(~/.zsh-tested-completions $fpath)
autoload -Uz compinit && compinit -D
# zstyle
# the names of the completer functions to use
zstyle ':completion:*' completer _expand _complete _correct _approximate
# various formats
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# menu selection with a cursor will be used when the number of possible matches doesn't fit the screen
zstyle ':completion:*' menu select=long
# menu selection with a cursor will be used for gpg commands
zstyle ':completion:*:gpg:*' menu select=2
# menu selection with a cursor will be used for git commands
zstyle ':completion:*:git*:*' menu select=2
# setup colors for ls
eval "$(dircolors -b)"
# make files matches use colors from LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# don't use the old compctl completion system
zstyle ':completion:*' use-compctl false
# Use better completion for the kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# ignore completion to functions starting with _
zstyle ':completion:*:functions' ignored-patterns '_*'
# Use completion cache
zstyle ':completion::complete:*' use-cache true
# Command failure
if [ -f /etc/zsh_command_not_found ]; then
	source /etc/zsh_command_not_found
elif [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# {{{1 History.
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Share history between all sessions.
setopt SHARE_HISTORY
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Keep 1000 lines of history within the shell
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.local/share/zsh/history"

# {{{1 Bindings
bindkey -v
# The time lapse between <Esc> and changing to insert mode.
export KEYTIMEOUT=1
# Word movement just like in my vim config.
bindkey -a e vi-forward-word-end
bindkey -a w vi-backward-word
bindkey -a E vi-forward-blank-word-end
bindkey -a W vi-backward-blank-word
bindkey -a ge vi-forward-word
bindkey -a gw vi-backward-word-end
bindkey -a gE vi-forward-blank-word
bindkey -a gW vi-backward-blank-word-end
# zkbd for special keys which their code changes often
autoload zkbd;
# source zkbd files according to the $TERMinal
if [[ -f "${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${DISPLAY:-$VENDOR-$OSTYPE}" ]]; then
	source "${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${DISPLAY:-$VENDOR-$OSTYPE}"
	bindkey "${key[Home]}" beginning-of-line
	bindkey -a "${key[Home]}" beginning-of-line
	bindkey "${key[End]}" end-of-line
	bindkey -a "${key[End]}" end-of-line
	bindkey "${key[Delete]}" delete-char
	bindkey -a "${key[Delete]}" delete-char
else
	echo you need to run \`zkbd\` for this terminal.
fi
# Fix bracket paste in zle for tmux only:
if [[ $TERM =~ .*tmux.* ]]; then
	unset zle_bracketed_paste
fi

# {{{1 ZLE
# sync with system clipboard
source ~/.zsh-system-clipboard/zsh-system-clipboard.zsh
# enable inline comments
setopt interactivecomments

# {{{1 Looks
# syntax highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fpath=(~/.zsh-prompts $fpath)
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
prompt my

# {{{1 aliases and functions
source ~/.aliases
source ~/.functions

# {{{1 chpwd
[[ -f ~/.zsh-chpwd ]] && source ~/.zsh-chpwd

# {{{1 modeline
# vim:ft=zsh:foldmethod=marker
