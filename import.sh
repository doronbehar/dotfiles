# general:
rsync ~/.profile ./.profile
# bash:
rsync ~/.bashrc ./.bashrc
# bash&&zsh
rsync -av --delete ~/.config/powerline/ ./.config/powerline/
rsync -av --delete ~/.shell/ ./.shell/
# zsh:
rsync ~/.zshrc ./
rsync -av ~/.zsh/ ./.zsh/
# git:
rsync ~/.gitconfig ./
# vim:
rsync -av --delete ~/.vim/ ./.vim/
rsync ~/.vimrc ./
# tmux:
rsync -av --delete ~/.tmux/ ./.tmux/
rsync ~/.tmux.conf ./.tmux.conf
echo import file \`~/.tmux-powerlinerc\`? it holds a passowrd for gmail which will have to be changed afterwards.. answer y/n/yes/no
read a
if [ "$a" = "y" ] || [ "$a" = "yes" ]; then
	rsync ~/.tmux-powerlinerc ./.tmux-powerlinerc
	vim .tmux-powerlinerc
fi
