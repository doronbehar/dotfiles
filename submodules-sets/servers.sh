#!/bin/sh

update_all=(
	.config/git
	.config/pip
	.config/pulse
	.config/ranger
	.config/lf
	.cpan/CPAN
	.gnupg
	.ssh
	.tmux
	.zsh-completions
	.zsh-syntax-highlighting
	.zsh-system-clipboard
)

git submodule init -- $update_all
git submodule update --recursive --checkout

update_selectively=(
	.config/nvim
)

this_repo=$(cd $(dirname $0)/.. && pwd -P)

for sm in $update_selectively; do
	git submodule init -- $this_repo/$sm
	cd $this_repo/$sm
	source ./submodules-sets/$(basename $0)
	cd $this_repo
done
