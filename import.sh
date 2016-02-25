# general:
chmod -R u+w `pwd`
cp ~/.profile ./
# bash:
cp ~/.bashrc ./
# bash&&zsh
cp -r ~/.config/powerline ./.config/
cp ~/.shell/aliases ./.shell/
# zsh:
cp ~/.zshrc ./
cp -r ~/.zsh/themes ./.zsh/
# git:
cp ~/.gitconfig ./
# vim:
cp -r ~/.vim ./
cp ~/.vimrc ./
# tmux:
cp -r ~/.tmux ./
cp ~/.tmux.conf ./
echo import file \`~/.tmux-powerlinerc\`? it holds a passowrd for gmail which will have to be changed afterwards.. answer y/n/yes/no
read a
if [ "$a" = "y" ] || [ "$a" = "yes" ]; then
	cp ~/.tmux-powerlinerc ./
	vim .tmux-powerlinerc
fi
