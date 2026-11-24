# Copy the contents of this file to C:/msys64/etc/zsh/zshenv for a complete
# correct setup.


# Make it work with Windows' native OpenSSH. Has to be set in /etc/zsh/zshenv
# because we need to set the true msys64 home directory before ZSH tries to
# read .zshrc etc from `C:/Users/$USER/`.
if [[ -n $SSH_CONNECTION && -d /home/$USER ]]; then
  export HOME=/home/$USER
  export MSYSTEM=${MSYSTEM:-UCRT64}
  cd $HOME
fi

# vim: ft=zsh
