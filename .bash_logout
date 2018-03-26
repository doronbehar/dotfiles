#!/bin/bash

[[ -f "$HOME/.local/share/zsh/${TERM}/logout" ]] && source "$HOME/.local/share/zsh/${TERM}/logout"
[[ -f "$HOME/.local/share/zsh/${DISPLAY}/logout" ]] && source "$HOME/.local/share/zsh/${DISPLAY}/logout"
[[ -f "$HOME/.local/share/zsh/${VENDOR}/logout" ]] && source "$HOME/.local/share/zsh/${VENDOR}/logout"
[[ -f "$HOME/.local/share/zsh/${OSTYPE}/logout" ]] && source "$HOME/.local/share/zsh/${OSTYPE}/logout"
[[ -f "$HOME/.local/share/zsh/${HOST}/logout" ]] && source "$HOME/.local/share/zsh/${HOST}/logout"
[[ -f "$HOME/.local/share/zsh/${FQDN}/logout" ]] && source "$HOME/.local/share/zsh/${FQDN}/logout"
[[ -f "$HOME/.local/share/zsh/${DOMAIN}/logout" ]] && source "$HOME/.local/share/zsh/${DOMAIN}/logout"

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
