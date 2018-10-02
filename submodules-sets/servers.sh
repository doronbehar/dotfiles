git submodule init -- \
	.config/git \
	.config/pip \
	.config/pulse \
	.config/ranger \
	.cpan/CPAN \
	.gnupg \
	.ssh \
	.tmux \
	.zsh-completions \
	.zsh-syntax-highlighting \
	.zsh-system-clipboard
git submodule update --recursive --checkout

git submodule init -- .config/nvim
git -C .config/nvim submodule init -- \
	bundle/AnsiEsc \
	bundle/SimpylFold \
	bundle/abolish \
	bundle/airline \
	bundle/ale \
	bundle/bbye \
	bundle/bufexplorer \
	bundle/css-color \
	bundle/csv \
	bundle/devicons \
	bundle/dirdiff \
	bundle/easymotion \
	bundle/editorconfig \
	bundle/eunuch \
	bundle/highlitedyank \
	bundle/info \
	bundle/neomutt \
	bundle/nerdcommenter \
	bundle/nerdtree \
	bundle/orgmode \
	bundle/pandoc \
	bundle/pandoc-syntax \
	bundle/pathogen \
	bundle/peekaboo \
	bundle/push \
	bundle/qf_resize \
	bundle/repeat \
	bundle/rooter \
	bundle/sandwich \
	bundle/searchindex \
	bundle/signify \
	bundle/sleuth \
	bundle/speeddating \
	bundle/stay \
	bundle/suda \
	bundle/tabular \
	bundle/targets \
	bundle/textobj-fold \
	bundle/textobj-keyvalue \
	bundle/textobj-quotes \
	bundle/textobj-underscore \
	bundle/textobj-uri \
	bundle/textobj-user \
	bundle/tmux-focus-events \
	bundle/tmux-navigator \
	bundle/tmux-syntax \
	bundle/togglelist \
	bundle/tradewinds \
	bundle/transpose \
	bundle/unicode \
	bundle/visualrepeat \
	bundle/window-swap
git -C .config/nvim submodule update --recursive --checkout
