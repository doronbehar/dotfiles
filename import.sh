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
_vim(){
	rsync -av --delete ~/.vim/ ./.vim/
	rsync ~/.vimrc ./
}
_tmux(){
	rsync -av --delete ~/.tmux/ ./.tmux/
	rsync ~/.tmux.conf ./.tmux.conf
}
_ncmpcpp(){
	rsync -av --delete ~/.ncmpcpp/ ./.ncmpcpp/
}

case "$1" in
	shells)
		_shells
		;;
	git)
		_git
		;;
	vim)
		_vim
		;;
	tmux)
		_tmux
		;;
	ncmpcpp)
		_ncmpcpp
		;;
	*)
		_ncmpcpp
		_tmux
		_vim
		_git
		_shells
		# print the status:
		git status
		;;
esac
# vim: ft=sh
