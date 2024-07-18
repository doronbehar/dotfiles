#!/bin/zsh

# To profile startup
# zmodload zsh/zprof

# {{{1 Uncategorized
# Why would I want to exclude hidden files?
setopt GLOB_DOTS
# allow more sophisticated glob patterns
setopt EXTENDEDGLOB
# allow ?, ~ and = to be used even if unmatched -
# http://zsh.sourceforge.net/Doc/Release/Options.html#index-NOMATCH
setopt nonomatch

# {{{ Completions
if [[ -d ${ZDOTDIR:-$HOME}/.zsh/comp/local ]]; then
	fpath=(${ZDOTDIR:-$HOME}/.zsh/comp/local $fpath)
fi
if [[ -d ${ZDOTDIR:-$HOME}/.nix-profile/share/zsh/site-functions ]]; then
	fpath=(${ZDOTDIR:-$HOME}/.nix-profile/share/zsh/site-functions $fpath)
fi
if [[ -d ${ZDOTDIR:-$HOME}/.zsh/comp/untracked ]]; then
	fpath=(${ZDOTDIR:-$HOME}/.zsh/comp/untracked $fpath)
fi
if [[ -d ${ZDOTDIR:-$HOME}/.zsh/comp/tested ]]; then
	fpath=(${ZDOTDIR:-$HOME}/.zsh/comp/tested $fpath)
fi
if [[ -d ${ZDOTDIR:-$HOME}/.zsh/comp/community/src ]]; then
	fpath=(${ZDOTDIR:-$HOME}/.zsh/comp/community/src $fpath)
fi
fpath(){
	printf '%s\n' "${fpath[@]}"
}
# Exclude fpath directories that I don't want to use their completion
fpath_exclude=(
	# This directory includes a _git file which I don't want, see:
	# https://lore.kernel.org/git/mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p/T/#u
	/nix/var/nix/profiles/default/share/zsh/site-functions
)
fpath=(${fpath:|fpath_exclude})
autoload -Uz compinit && compinit -D
# Fix a completion collision between devtodo and todo
compdef _todo todo
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
# setup colors for ls only if needed
if [[ -z "$LS_COLORS" ]]; then
	test -r ${ZDOTDIR:-$HOME}/.dircolors && eval "$(dircolors -b ${ZDOTDIR:-$HOME}/.dircolors)" || eval "$(dircolors -b)"
fi
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
if [[ -z ${functions[command_not_found_handler]} ]]; then
	if [ -f /etc/zsh_command_not_found ]; then
		source /etc/zsh_command_not_found
	elif [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
		source /usr/share/doc/pkgfile/command-not-found.zsh
	fi
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
# Ignore hsub history substituter
export HISTORY_IGNORE="hsub"
function zshaddhistory() {
	emulate -L zsh
	! [[ "$1" =~ "${HISTORY_IGNORE}" ]]
}

# {{{1 ZLE
# automatically escape URLs
# /usr/share/zsh/functions/Zle/url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# Zle widgets based on examples distributed with fzf
export FZF_COMPLETION_TRIGGER=''
# source all completions based on _fzf_completion for the various commands
# https://github.com/junegunn/fzf/wiki/Examples-(completion)
source ${ZDOTDIR:-$HOME}/.zsh/zle/fzf/personal-widgets
# macro-complete widget, these are usually sourced from a different repository,
# and hence we don't use the ZDOTDIR here
if [[ -f ~/.local/share/zsh/macros/${HOST} ]]; then
	source ~/.local/share/zsh/macros/${HOST}
fi
# sync with system clipboard, only if programs available
# https://github.com/kutsan/zsh-system-clipboard
if _command_exists xclip || _command_exists xsel || _command_exists wl-copy || _command_exists clip.exe; then
	export ZSH_SYSTEM_CLIPBOARD_DISABLE_DEFAULT_MAPS=1
	source ${ZDOTDIR:-$HOME}/.zsh/zle/system-clipboard/zsh-system-clipboard.zsh
	function () {
		local binded_keys i parts key cmd keymap
		for keymap in vicmd visual emacs; do
			binded_keys=(${(f)"$(bindkey -M $keymap)"})
			for (( i = 1; i < ${#binded_keys[@]}; ++i )); do
				parts=("${(z)binded_keys[$i]}")
				key="${parts[1]}"
				cmd="${parts[2]}"
				if (( $+functions[zsh-system-clipboard-$keymap-$cmd] )); then
					eval bindkey -M $keymap \"\ \"$key zsh-system-clipboard-$keymap-$cmd
				fi
			done
		done
		bindkey -ar " "
	}
fi
# enable inline comments
setopt interactivecomments
# syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source ${ZDOTDIR:-$HOME}/.zsh/zle/syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

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
# don't exit last tmate pane / window, based on: https://superuser.com/a/1702473/430539
if [[ "$TMUX" =~ "tmate-$UID" ]]; then
	# tmux detach or delete
	function tmate-safe-exit() {
		if [[ -n "${BUFFER}" ]]
		then
			zle delete-char-or-list
		else
			# Naturally if $TMUX has tmate-$UID tmate is installed...
			if [[ "$(tmate list-panes -a | wc -l)" == "1" && -z "$NVIM" && -z "$VIM" ]]; then
				echo "do not try to exit the last tmate pane!"
			else
				exit
			fi
		fi
	}
	if [[ -n "$TMUX" ]]; then
		setopt ignoreeof
		zle -N tmate-safe-exit
		bindkey "^D" tmate-safe-exit
	fi
fi
# Fix bracket paste in zle for tmux only:
if [[ $TERM =~ .*tmux.* ]]; then
	unset zle_bracketed_paste
fi
# create quotes text objects
# /usr/share/zsh/functions/Zle/select-quoted
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
	for c in {a,i}{\',\",\`}; do
		bindkey -M $m $c select-quoted
	done
done
# create brackets text objects
# /usr/share/zsh/functions/Zle/select-bracketed
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
	for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
		bindkey -M $m $c select-bracketed
	done
done
# full text editor editing of the command
autoload edit-command-line && zle -N edit-command-line
bindkey -M viins "^V" edit-command-line
bindkey -M vicmd "^V" edit-command-line
# fzf completions
source ${ZDOTDIR:-$HOME}/.zsh/zle/fzf/tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' continuous-trigger ""
zstyle ':fzf-tab:*' switch-group 'ctrl-n' 'ctrl-m'
zstyle ':fzf-tab:complete:(j(u|s)f|systemctl-)*:*' fzf-preview 'env words="$words" $HOME/.zsh/zle/fzf/previewers/systemctl'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
	'[[ $group == "Completing process ID" ]] && pstree -a $word'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:git*' fzf-preview 'env words="$words" word=${word%% } $HOME/.zsh/zle/fzf/previewers/git'
zstyle ':fzf-tab:complete:git*' fzf-flags --preview-window=right:55%:wrap
zstyle ':fzf-tab:complete:git*' fzf-min-height 10000
bindkey -M viins "^ " fzf-complete-macro
bindkey -M viins "^Z" fzf-complete-history-commands
bindkey -M viins "^A" fzf-complete-history-words
bindkey -M viins "^T" fzf-complete-history-paths
bindkey -M viins "^P" fzf-complete-git-all-files
bindkey -M viins "^Y" fzf-complete-git-changed-files

# {{{1 Looks
source ${ZDOTDIR:-$HOME}/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# If SSH_TMUX_ATTACH is set, then we are sshing from the main home computer.
# If TERM_NO_ICONS_FONT is set, we have made
# if [ -n $SSH_TMUX_ATTACH ] || zmodload zsh/terminfo && (( terminfo[colors] >= 256 )) && [ -z $TERM_NO_ICONS_FONT ]; then
zmodload zsh/terminfo
(){
	if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
		[[ ! -f ${ZDOTDIR:-$HOME}/.zsh/p10k/wsl ]] || source ${ZDOTDIR:-$HOME}/.zsh/p10k/wsl
		return
	fi
	if [ ! -z "$SSH_TMUX_ATTACH$MLTERM" ]; then
		[[ ! -f ${ZDOTDIR:-$HOME}/.zsh/p10k/default ]] || source ${ZDOTDIR:-$HOME}/.zsh/p10k/default
		return
	fi
	if (( terminfo[colors] >= 256 )); then
		# TELEPORT_SESSION is for teleconsole (https://www.teleconsole.com/)
		# SSH_TERM_NO_ICONS_FONT is inherited between ssh sessions, for example
		# when sshing to vps from a terminal with no suitable fonts.
		if [[ -z "$SSH_TERM_NO_ICONS_FONT" ]] && [[ -z "$TELEPORT_SESSION" ]]; then
			[[ ! -f ${ZDOTDIR:-$HOME}/.zsh/p10k/default ]] || source ${ZDOTDIR:-$HOME}/.zsh/p10k/default
			return
		fi
	fi
	[[ ! -f ${ZDOTDIR:-$HOME}/.zsh/p10k/ascii ]] || source ${ZDOTDIR:-$HOME}/.zsh/p10k/ascii
}

# {{{1 Enable tracing a specific function
if [ -n "${TRACE_FUNC}" ]; then
	functions -t "$TRACE_FUNC"
fi

# {{{1 shell common functions and aliases
for i in ${ZDOTDIR:-$HOME}/.shell/*; do
	. "$i"
done

# {{{1 chpwd - mostly for taskwarrior context
for i in ${ZDOTDIR:-$HOME}/.zsh/chpwd/*; do
	. "$i"
done

# {{{1 precmd - mostly for direnv
for i in ${ZDOTDIR:-$HOME}/.zsh/precmd/*; do
	. "$i"
done

# Unset i used in the above 3 loops
unset i

# To profile startup
#zprof

# {{{1 modeline
# vim:ft=zsh:foldmethod=marker
