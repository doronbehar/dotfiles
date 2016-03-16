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
