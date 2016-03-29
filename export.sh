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
# git:
rsync .gitconfig ~/
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
# mpd/mpc/ncmpcpp
mkdir -p ~/.ncmpcpp
mkdir -p ~/.mpd
rsync -av --delete ./.ncmpcpp/ ~/.ncmpcpp/
rsync .mpdconf ~/.mpdconf
