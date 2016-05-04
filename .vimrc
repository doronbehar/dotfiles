set nocompatible
set modeline
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" no word wrap:
set nowrap
if &diff
	set wrap
	set diffopt+=iwhite
endif
" highlight search during typing:
set nohlsearch
filetype plugin on
filetype indent on
set autoread
syntax enable
" enable mouse actions
set mouse=a
colorscheme koehler
set background=dark
set encoding=utf8
set autoindent
set smartindent
" incremental search
set incsearch
" make a double-click on '/' while in visual/select mode execute a search
" through document for the selected text:
vnoremap // y/<C-R>"<CR>
" make vim's * register compatible with system's clipboard:
set clipboard=unnamedplus
" tab's and indentation preferences:
set shiftwidth=4
set ts=4 " tabsize
set preserveindent
set noexpandtab
" make <c-r> insert the current visually selected text inserted into a replace
" text inside vim's command line
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left> <backspace>
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
" make certain settings for certain filetypes:
source ~/.vim/filetype-specific-settings
" create a command that sets up all normal word wrap "Wrap"
command! -nargs=* Wrap set wrap linebreak nolist
" make double click on escape button execute `noh` which unhighlights all
" previously search's results
nnoremap <esc><esc> :noh <enter>
" powerline:
source ~/.vim/powerline
" make the return to normal mode with escape not take too long and confuse me:
set timeoutlen=1000
set ttimeoutlen=0
set t_Co=256
set splitbelow
set splitright
" Always display the statusline in all windows:
set laststatus=2
" Always display the tabline, even if there is only one tab:
set showtabline=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline):
set noshowmode
" make plugin installations easy and use github-plugins from ~/.vim/bundle:
let g:pathogen_disabled = []
execute pathogen#infect()
" make reading help documents for Plugins easier:
Helptags
source ~/.vim/abbreviations
source ~/.vim/key-mapping
set list listchars=tab:›\ ,trail:-,extends:>,precedes:<,eol:¬
set foldenable
set foldmethod=indent
set foldcolumn=2
" fix rendering:
set tenc=utf8
" make foldings-view automatic:
autocmd BufWinLeave * mkview!
autocmd BufWinEnter * silent loadview
" plugin settings:
" - gitgutter signs:
let g:gitgutter_sign_added = '﬩ '
let g:gitgutter_sign_modified = '≈ '
let g:gitgutter_sign_removed = '⌐ '
let g:gitgutter_sign_modified_removed = '⌐˯'
