#!/bin/zsh

# {{{ **last actions**
# - Load local environmental variables for login interactive sessions according to the $DISPLAY and various other variables
[[ -f ~/.local/share/zsh/login-"${_CURRENT_SHELL_ENVIRONMENT}-${HOST}" ]] && \
	source ~/.local/share/zsh/login-"${_CURRENT_SHELL_ENVIRONMENT}-${HOST}"
# }}}

# vim:ft=zsh:foldmethod=marker
