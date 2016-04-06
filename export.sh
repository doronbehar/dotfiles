<<<<<<< HEAD
# general:
rsync .profile ~/.profile
# bash:
rsync .bashrc ~/.bashrc
# bash&&zsh
rsync -av --delete .config/powerline/ ~/.config/powerline/
mkdir -p ~/.profile.d
rsync -av --delete .profile.d/ ~/.profile.d/
# zsh:
rsync .zshrc ~/
rsync -av .zsh/ ~/.zsh/
||||||| merged common ancestors
# general:
rsync .profile ~/.profile
# bash:
rsync .bashrc ~/.bashrc
# bash&&zsh
rsync -av --delete .config/powerline/ ~/.config/powerline/
mkdir -p ~/.shell
rsync -av --delete .shell/ ~/.shell/
# zsh:
rsync .zshrc ~/
rsync -av .zsh/ ~/.zsh/
=======
# shells:
rsync ./.profile ~/.profile
rsync ./.bashrc ~/.bashrc
rsync ./.config/powerline/ ~/.config/powerline/
rsync ./.zprofile ~/.zprofile
rsync ./.zlogin ~/.zlogin
rsync ./.zshenv ~/.zshenv
rsync ./.zshrc ~/.zshrc
mkdir -p ~/.zsh
rsync -av --delete ./.zsh/ ~/.zsh/
>>>>>>> shells
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
<<<<<<< HEAD
rsync .mpdconf ~/.mpdconf
# vim: ft=sh
||||||| merged common ancestors
rsync .mpdconf ~/.mpdconf
=======
# vim: ft=sh
>>>>>>> shells
