# shells:
rsync ./.profile ~/.profile
rsync ./.bashrc ~/.bashrc
rsync ./.config/powerline/ ~/.config/powerline/
rsync ./.zprofile ~/.zprofile
rsync ./.zlogin ~/.zlogin
rsync ./.zshenv ~/.zshenv
rsync ./.zshrc ~/.zshrc
mkdir -p ~/.sh
rsync -av --delete ./.sh/ ~/.sh/
mkdir -p ~/.bin
rsync -av --delete ./.bin/ ~/.bin/
# git:
rsync ./.gitconfig ~/.gitconfig
# vim:
mkdir -p ~/.vim
rsync -av --delete .vim/ ~/.vim/
rsync .vimrc ~/
# tmux:
mkdir -p ~/.tmux
rsync -av --delete .tmux/ ~/.tmux/
rsync .tmux.conf ~/.tmux.conf
if [ `which powerline` = "powerline not found" ]; then
	if [ `sudo -v` = "Sorry, user $USER may not run sudo on $HOSTNAME" ]; then
		if [ `which pip` != "pip not found" ]; then
			pip install powerline-status
		else
			echo try to install pip or use the git repository to install powerline
		fi
	else
		sudo apt-get install powerline
	fi
fi
# ncmpcpp
mkdir -p ~/.ncmpcpp
rsync -av --delete ./.ncmpcpp/ ~/.ncmpcpp/
# vim: ft=sh
