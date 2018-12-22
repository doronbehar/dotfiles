#!/bin/zsh

# **last actions**
# - Load local environmental variables for login interactive sessions according to the $DISPLAY and various other variables
if [[ -f "$HOME/.local/share/zsh/${TERM}/login" ]]; then
	source "$HOME/.local/share/zsh/${TERM}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${DISPLAY}/login" ]]; then
	source "$HOME/.local/share/zsh/${DISPLAY}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${VENDOR}/login" ]]; then
	source "$HOME/.local/share/zsh/${VENDOR}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${OSTYPE}/login" ]]; then
	source "$HOME/.local/share/zsh/${OSTYPE}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${HOST}/login" ]]; then
	source "$HOME/.local/share/zsh/${HOST}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${FQDN}/login" ]]; then
	source "$HOME/.local/share/zsh/${FQDN}/login"
fi
if [[ -f "$HOME/.local/share/zsh/${DOMAIN}/login" ]]; then
	source "$HOME/.local/share/zsh/${DOMAIN}/login"
fi

# vim:ft=zsh:foldmethod=marker
