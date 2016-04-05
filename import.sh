# general:
rsync ~/.profile ./.profile
# bash:
rsync ~/.bashrc ./.bashrc
# bash&&zsh
rsync -av --delete ~/.config/powerline/ ./.config/powerline/
rsync -av --delete ~/.profile.d/ ./.profile.d/
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
# mpd/mpc/ncmpcpp
rsync -av --delete ~/.ncmpcpp/ ./.ncmpcpp/
rsync .mpdconf ~/.mpdconf
# print the status:
git status
# vim: ft=sh
