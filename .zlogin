#!/bin/zsh

# **last actions**
# - Load local environmental variables for login interactive sessions according to the $DISPLAY and various other variables
if [[ -f "$HOME/.local/share/zsh/login/${TERM}" ]]; then
	source "$HOME/.local/share/zsh/login/${TERM}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${DISPLAY}" ]]; then
	source "$HOME/.local/share/zsh/login/${DISPLAY}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${VENDOR}" ]]; then
	source "$HOME/.local/share/zsh/login/${VENDOR}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${OSTYPE}" ]]; then
	source "$HOME/.local/share/zsh/login/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/login/${HOST}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${FQDN}" ]]; then
	source "$HOME/.local/share/zsh/login/${FQDN}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${DOMAIN}" ]]; then
	source "$HOME/.local/share/zsh/login/${DOMAIN}"
fi

# vim:ft=zsh:foldmethod=marker
