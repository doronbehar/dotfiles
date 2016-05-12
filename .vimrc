set nocompatible
set modeline
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" no word wrap:
set nowrap
if &diff
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
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

" make <c-r> insert the current visually selected text inserted into a replace
" text inside vim's command line:
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left> <backspace>
vnoremap <C-R> "gy:%s/\<<C-r>g\>//gc<left><left><left> <backspace>
" make a double click on escape button execute `noh` which unhighlights all
" previously search's results
nnoremap <esc><esc> :noh <enter>

" Custom commands:
source ~/.vim/commands

" make certain settings for certain filetypes:
" - markdown: spellchecking and wrap
autocmd Filetype markdown Wrap
" - gitcommit: spellcheck
autocmd Filetype gitcommit setlocal spell



" make the return to normal mode with escape not take too long and confuse me:
set timeoutlen=1000
set ttimeoutlen=0
set t_Co=256

" Easier to launch new splits:
set splitbelow
set splitright

" Always display the statusline in all windows:
set laststatus=2
" Always display the tabline, even if there is only one tab:
set showtabline=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline):
set noshowmode

" powerline:
" make plugin installations easy and use github-plugins from ~/.vim/bundle:
execute pathogen#infect()
" make reading help documents for Plugins easier:
Helptags
if !has('nvim')
	let g:pathogen_disabled = ["airline"]
	python from powerline.vim import setup as powerline_setup
	python powerline_setup()
	python del powerline_setup
	"set rtp+=/usr/lib/python3.5/site-packages/powerline/bindings/vim
else
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	" disable file encoding if width is smaller than 50:
	call airline#parts#define_minwidth('ffenc', 50)
	let g:airline_symbols.maxlinenr = 'Ξ'
	let g:airline_theme = 'powerlineish'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1
endif

" abbreviations:
source ~/.vim/abbreviations

" Key mappings:
source ~/.vim/mappings

set list listchars=tab:›\ ,trail:-,extends:»,precedes:«,eol:¬
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
let g:gitgutter_sign_added = '+ '
let g:gitgutter_sign_modified = '≈ '
"let g:gitgutter_sign_removed = '⌐ '
" - NERDTree open automatically when no file is specified:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeDirArrowExpandable = '»'
let g:NERDTreeDirArrowCollapsible = '¬'
let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeShowLineNumbers = 1
