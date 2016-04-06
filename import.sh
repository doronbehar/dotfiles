# shells:
rsync ~/.profile ./.profile
rsync ~/.bashrc ./.bashrc
rsync ~/.config/powerline/ ./.config/powerline/
rsync ~/.zprofile ./.zprofile
rsync ~/.zlogin ./.zlogin
rsync ~/.zshenv ./.zshenv
rsync ~/.zshrc ./.zshrc
rsync -av --delete ~/.sh/ ./.sh/
# git:
rsync ~/.gitconfig ./.gitconfig
# vim:
rsync -av --delete ~/.vim/ ./.vim/
rsync ~/.vimrc ./
# tmux:
rsync -av --delete ~/.tmux/ ./.tmux/
rsync ~/.tmux.conf ./.tmux.conf
# ncmpcpp
rsync -av --delete ~/.ncmpcpp/ ./.ncmpcpp/
# print the status:
git status
# vim: ft=sh
