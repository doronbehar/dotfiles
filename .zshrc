# Set up the prompt:
#plugins=(rails git textmate ruby lighthouse)
## set the dircetory for the 'Oh My ZSH' functions directory:
#ZSH=~/.config/powerline/zsh
## load functions:
#source $ZSH/autoload
## variable exported for 'agnoster' theme
#export DEFAULT_USER=$USER
## variables ment for default theme:
#export POWERLINE_RIGHT_A="exit-status-on-fail"
#export POWERLINE_PATH="short"
#export POWERLINE_DETECT_SSH="true"
#export POWERLINE_HIDE_HOST_NAME="true"
#export POWERLINE_NO_BLANK_LINE="true"
## load the theme wanted:
#source ~/.zsh/themes/default
# other powerline theme - works smarte:
. /usr/share/powerline/bindings/zsh/powerline.zsh


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh/history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh/history

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
source ~/.zsh/aliases
# the following line is as described in a user-guide by powerline:
# source: http://powerline.readthedocs.org/en/master/usage/shell-prompts.htm#zsh-prompt
# . /usr/share/powerline/bindings/zsh/powerline.zsh
HISTIGNORE="ls:history*:fg:exit:ls -[lahLAH]:ls -l[ahAH]:ls -a[lhLH]:ls -h[laLA]:ls -la[hH]:ls -lh[aA]:ls -al[hH]"
export QSYS_ROOTDIR="/opt/altera.15.1/quartus/sopc_builder/bin"

export ALTERAOCLSDKROOT="/opt/altera.15.1/hld"
PATH=$PATH:/home/doron/.bin
export PAGER=`which most`
