_shells(){
	rsync ~/.profile ./.profile
	rsync ~/.bashrc ./.bashrc
	rsync ~/.config/powerline/ ./.config/powerline/
	rsync ~/.zprofile ./.zprofile
	rsync ~/.zlogin ./.zlogin
	rsync ~/.zshenv ./.zshenv
	rsync ~/.zshrc ./.zshrc
	rsync -av --delete ~/.sh/ ./.sh/
	rsync -av --delete ~/.bin/ ./.bin/
}
_git(){
	rsync ~/.gitconfig ./.gitconfig
}
_ncmpcpp(){
	rsync -av --delete ~/.ncmpcpp/ ./.ncmpcpp/
}
_X(){
	rsync ~/.Xdefaults ./.Xdefaults
	rsync ~/.Xresources ./.Xresources
	rsync ~/.Xinitrc ./.Xinitrc
	rsync ~/.Xsessionrc ./.Xsessionrc
}
_transmission(){
	rsync -av --delete ~/.config/transmission-remote-cli/ .config/transmission-remote-cli/
}
case "$1" in
	shells)
		_shells
		;;
	git)
		_git
		;;
	ncmpcpp)
		_ncmpcpp
		;;
	X)
		_X
		;;
	transmission)
		_transmission
		;;
	*)
		_ncmpcpp
		_tmux
		_vim
		_git
		_shells
		_X
		_transmission
		# print the status:
		git status
		;;
esac
# vim: ft=sh
