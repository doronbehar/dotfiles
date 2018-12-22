#!/bin/bash

if [[ -f "$HOME/.local/share/zsh/${TERM}/logout" ]]; then
	source "$HOME/.local/share/zsh/${TERM}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${DISPLAY}/logout" ]]; then
	source "$HOME/.local/share/zsh/${DISPLAY}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${VENDOR}/logout" ]]; then
	source "$HOME/.local/share/zsh/${VENDOR}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${OSTYPE}/logout" ]]; then
	source "$HOME/.local/share/zsh/${OSTYPE}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${HOST}/logout" ]]; then
	source "$HOME/.local/share/zsh/${HOST}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${FQDN}/logout" ]]; then
	source "$HOME/.local/share/zsh/${FQDN}/logout"
fi
if [[ -f "$HOME/.local/share/zsh/${DOMAIN}/logout" ]]; then
	source "$HOME/.local/share/zsh/${DOMAIN}/logout"
fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
