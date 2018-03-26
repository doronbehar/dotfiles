#!/bin/zsh

# **last actions**
# - Load local environmental variables for login interactive sessions according to the $DISPLAY and various other variables
[[ -f "$HOME/.local/share/zsh/${TERM}/login" ]] && source "$HOME/.local/share/zsh/${TERM}/login"
[[ -f "$HOME/.local/share/zsh/${DISPLAY}/login" ]] && source "$HOME/.local/share/zsh/${DISPLAY}/login"
[[ -f "$HOME/.local/share/zsh/${VENDOR}/login" ]] && source "$HOME/.local/share/zsh/${VENDOR}/login"
[[ -f "$HOME/.local/share/zsh/${OSTYPE}/login" ]] && source "$HOME/.local/share/zsh/${OSTYPE}/login"
[[ -f "$HOME/.local/share/zsh/${HOST}/login" ]] && source "$HOME/.local/share/zsh/${HOST}/login"
[[ -f "$HOME/.local/share/zsh/${FQDN}/login" ]] && source "$HOME/.local/share/zsh/${FQDN}/login"
[[ -f "$HOME/.local/share/zsh/${DOMAIN}/login" ]] && source "$HOME/.local/share/zsh/${DOMAIN}/login"

# vim:ft=zsh:foldmethod=marker
