# The following line is as described in a user-guide by powerline: # source: http://powerline.readthedocs.org/en/master/usage/shell-prompts.htm#zsh-prompt
# powerline:
powerline-daemon -q
if [ -f /usr/share/powerline/bindings/zsh/powerline.zsh ]; then
	. /usr/share/powerline/bindings/zsh/powerline.zsh
elif [ -f ~/.local/share/powerline/bindings/zsh/powerline.zsh ]; then
	. ~/.local/share/powerline/bindings/zsh/powerline.zsh
elif [ -f /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
	. /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
else
	echo "you don't seem to have powerline installed, check your ~/.zshrc and add the correct path to the bindings in ~/.zshrc and ~/.bashrc"
fi
# syntax highlighting:
source ~/.sh/syntax-highlighting/plugin

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
autoload -Uz compinit
compinit

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
if [ -f /etc/zsh_command_not_found ]; then
	source /etc/zsh_command_not_found
fi
# function that is not compatible this way written in bash:
'='(){
	awk "BEGIN{ print $* }"
}
