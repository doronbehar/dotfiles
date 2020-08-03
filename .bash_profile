#!/bin/bash

if [ -f "$HOME/.zshenv" ]; then
	. "$HOME/.zshenv"
fi
# shell common functions and aliases
for i in ~/.shell/*; do
	. "$i"
done
unset i
# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi
if [ -f "$HOME/.zlogin" ]; then
	. "$HOME/.zlogin"
fi
