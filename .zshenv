# function to append $PATH a directory only if it doesn't exist already.
# On my machine at home it overrides almost the same function. The difference
# is that the system wide function appends the argument in the beginning and
# not at the end of $PATH - It makes sense because this way a user has the
# choice of using custom scripts with the same name as some that exist on the
# system. When the interpretor reads $PATH it searches through the 1st
# directories 1st. So scripts in ~/.bin will be used over /bin for example.
add2PATH(){
	if ! echo $PATH | grep -q "$1"; then
		PATH="$1"":""$PATH"
	fi
}
if [ -d "$HOME/bin" ]; then
	add2PATH "$HOME/bin"
fi
# Include user's private bin directory if it exists
if [ -d "$HOME/.bin" ]; then
	add2PATH "$HOME/.bin"
fi
if [ -d "$HOME/.local/bin" ]; then
	add2PATH "$HOME/.local/bin"
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
