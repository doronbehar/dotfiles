#!/bin/zsh

# **last actions**
# - Load local environmental variables for login interactive sessions according to the $DISPLAY and various other variables
[[ -f ~/.local/share/zsh/"${_CURRENT_SHELL_ENVIRONMENT}-${HOST}"/login ]] && \
	source ~/.local/share/zsh/"${_CURRENT_SHELL_ENVIRONMENT}-${HOST}"/login

# vim:ft=zsh:foldmethod=marker
