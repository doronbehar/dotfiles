# update only ssh submodule (anonymously)
git -C ~/repos/dotfiles/.ssh init
git -C ~/repos/dotfiles/.ssh remote add origin git://github.com/doronbehar/.ssh
git -C ~/repos/dotfiles/.ssh pull origin master
git -C ~/repos/dotfiles submodule init ~/repos/dotfiles/.ssh absorbgitdirs || echo bootstrap: could not absorbgitdirs of .ssh submodule
mv ~/.ssh/known_hosts ~/repos/dotfiles/.ssh || echo bootstrap: no known_hosts file was present to move to real ssh directory
rmdir ~/.ssh || echo bootstrap: no ~/.ssh dir was present
ln -s -r ~/repos/dotfiles/.ssh ~/.ssh
git clone ~/private-repos/ssh ~/.ssh/config.d
ssh-keygen -f ~/.ssh/github
printf '%s' "bootstrap: Did you setup your github key?"
read yes
ssh-keygen -f ~/.ssh/gitlab
printf '%s' "bootstrap: Did you setup your gitlab key?"
read yes
ssh-keygen -f ~/.ssh/nuc
if ! ssh-copy-id nuc; then
	echo bootstrap: exiting since archpi ssh copy id has failed
	exit 2
fi
ssh-keygen -f ~/.ssh/archpi
if ! ssh-copy-id archpi; then
	echo bootstrap: exiting since archpi ssh copy id has failed
	exit 2
fi
mkdir -p ~/.config/systemd
git clone ~/private-repos/nuc/user/systemd ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user start ssh-agent.service
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
cd ~/repos/dotfiles 
if ! ./submodules-sets/"$1".sh; then
	echo bootstrap: could not run submodules sets for "$1"
	exit 2
fi
