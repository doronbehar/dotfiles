# set PATH so it includes user's private bin if it exists
add2PATH-only-if-arg-not-exist(){
	if ! echo $PATH | grep -q "$1"; then
		PATH="$1"":""$PATH"
	fi
}
if [ -d "$HOME/bin" ]; then
	add2PATH-only-if-arg-not-exist "$HOME/bin"
fi
if [ -d "$HOME/.bin" ]; then
	add2PATH-only-if-arg-not-exist "$HOME/.bin"
fi
if [ -d "$HOME/.local/bin" ]; then
	add2PATH-only-if-arg-not-exist "$HOME/.local/bin"
fi
export PAGER=`which less`
export LESS="-X"
export EDITOR=`which vim`
# Keep 1000 lines of history within the shell and save it to ~/.sh/history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.sh/history
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL="ignoredups:ignorespace"
