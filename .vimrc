set backspace=eol,start,indent " actionfor backspace
set whichwrap+=<,>,h,l
set nowrap " no word wrap
set hlsearch " highlight search during typing
filetype plugin on
filetype indent on
set autoread
syntax enable
set mouse=a " enable mouse actions
colorscheme desert
set background=dark
set encoding=utf8
set ai " auto indent
set si " smart indent
set wrap " wrap lines
set incsearch " incremental search
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
set backupdir=~/.vim/backup//
set directory=~/.vim/tmp//
" make double click on escape button execute `noh` which unhighlights all
" previously search's results
nnoremap <esc><esc> :noh <enter>
" for python-powerline:
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" for vim-airline powerline plugin:
"let g:airline_theme='badwolf'
"if !exists('g:airline_symbols')
"	let g:airline_symbols = {}
"endif
"let g:airline_detect_paste=1
"let g:airline_detect_modified=1
"let g:airline_powerline_fonts=0
"let g:airline_left_alt_sep = ''
"let g:airline_left_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.branch = ''
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline#extensions#bufferline#enabled = 0
" make the return to normal mode with escape not take too long and confuse me
set timeoutlen=1000
set ttimeoutlen=0
set t_Co=256
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" make plugin installations easy and use github-plugins from ~/.vim/bundle:
execute pathogen#infect()
" make reading help documents easier:
Helptags
source ~/.vim/abbreviations
source ~/.vim/key-mapping
