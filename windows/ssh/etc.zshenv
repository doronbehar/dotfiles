# Copy the contents of this file to C:/msys64/etc/zsh/zshenv for a complete
# correct setup.

# Default PROMPT
PROMPT="%F{green}%n@%m%f %F{magenta}${MSYSTEM}%f %F{yellow}%~%f %# "
PATH=/usr/bin:/ucrt64/bin:$PATH

# Make it work with Windows' native OpenSSH. Has to be set in /etc/zsh/zshenv
# because we need to set the true msys64 home directory before ZSH tries to
# read .zshrc etc from `C:/Users/$USER/`.
if [[ -n $SSH_CONNECTION && -d /home/$USER ]]; then
  export HOME=/home/$USER
  export MSYSTEM=${MSYSTEM:-UCRT64}
  cd $HOME
fi

# sshd sets $SHELL to DefaultShell verbatim. Without this, anything that execs
# $SHELL directly (rather than just using whatever shell it's already in)
# breaks: nvim shells out through it, tmux's default-shell rejects it and
# falls back to /usr/bin/bash, and `$SHELL -c ...` (e.g. `script`) fails
# outright.
export SHELL=/usr/bin/zsh

# DefaultShell is a bare executable path with no room for `-l`, so an
# interactive session (`ssh lab`) starts non-login and skips /etc/zsh/zprofile
# (hence /etc/profile too). Re-exec ourselves as login rather than wrapping
# DefaultShell in a .bat: a .bat forces every exec session through cmd.exe's
# own tokenizer on top of zsh's, breaking quoting (e.g.
# `ssh lab 'echo "a | b"'`). An exec session (`ssh lab cmd`) has no pty and so
# isn't interactive, so this leaves it non-login, same as a normal OpenSSH
# server. The re-exec re-runs this whole file, this time with `-o login` true,
# so the check is false the second time and startup continues normally.
[[ -o interactive && ! -o login ]] && exec /usr/bin/zsh -l

# vim: ft=zsh
