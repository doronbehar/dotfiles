#!/bin/bash

if [[ -f "$HOME/.local/share/zsh/logout/${TERM}" ]]; then
	source "$HOME/.local/share/zsh/logout/${TERM}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${DISPLAY}" ]]; then
	source "$HOME/.local/share/zsh/logout/${DISPLAY}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${VENDOR}" ]]; then
	source "$HOME/.local/share/zsh/logout/${VENDOR}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${OSTYPE}" ]]; then
	source "$HOME/.local/share/zsh/logout/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/logout/${HOST}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${FQDN}" ]]; then
	source "$HOME/.local/share/zsh/logout/${FQDN}"
fi
if [[ -f "$HOME/.local/share/zsh/logout/${DOMAIN}" ]]; then
	source "$HOME/.local/share/zsh/logout/${DOMAIN}"
fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
