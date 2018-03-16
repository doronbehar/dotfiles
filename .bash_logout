#!/bin/bash

[[ -f "$HOME/.local/share/zsh/${_CURRENT_SHELL_ENVIRONMENT}-${HOST}/logout" ]] && source "$HOME/.local/share/zsh/${_CURRENT_SHELL_ENVIRONMENT}-${HOST}/logout"

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
