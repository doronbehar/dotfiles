#!/bin/zsh

if [[ -f "$HOME/.local/share/zsh/login/${OSTYPE}" ]]; then
	source "$HOME/.local/share/zsh/login/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/zsh/login/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/login/${HOST}"
fi

# vim:ft=zsh:foldmethod=marker
