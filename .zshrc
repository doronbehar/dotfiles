# powerline:
if [ -f /usr/bin/powerline ]; then
	. /usr/share/powerline/bindings/zsh/powerline.zsh
elif [ -f ~/.local/bin/powerline ]; then
	. ~/.local/share/powerline/bindings/zsh/powerline.zsh
else
	echo "you don't have powerline installed, run \`git clone https://github.com/powerline/powerline .profile.d/powerline && source ~/.zshrc\` to fix it"
fi
# syntax highlighting:
source ~/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh/history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.profile.d/history

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
source ~/.profile.d/aliases
source /etc/zsh_command_not_found
# the following line is as described in a user-guide by powerline:
# source: http://powerline.readthedocs.org/en/master/usage/shell-prompts.htm#zsh-prompt
# . /usr/share/powerline/bindings/zsh/powerline.zsh
HISTIGNORE="ls:history*:fg:exit:ls -[lahLAH]:ls -l[ahAH]:ls -a[lhLH]:ls -h[laLA]:ls -la[hH]:ls -lh[aA]:ls -al[hH]"
