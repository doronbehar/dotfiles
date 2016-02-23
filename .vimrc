set nocompatible
set ts=4 " tabsize
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
set shiftwidth=4
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
" commands to manipulate tabs easily and quilckly:
nnoremap t<right> :tabm +1 <enter>
nnoremap t<left> :tabm -1 <enter>
nnoremap t0 :tabm 0 <enter>
nnoremap t1 :tabm 1 <enter>
nnoremap t2 :tabm 2 <enter>
nnoremap t3 :tabm 3 <enter>
nnoremap t4 :tabm 4 <enter>
nnoremap t5 :tabm 5 <enter>
nnoremap t6 :tabm 6 <enter>
nnoremap t7 :tabm 7 <enter>
nnoremap t8 :tabm 8 <enter>
nnoremap t9 :tabm 9 <enter>
nnoremap g<right> :tabn <enter>
nnoremap g<left> :tabp <enter>
nnoremap g0 :tabfirst <enter>
nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt
nnoremap g6 6gt
nnoremap g7 7gt
nnoremap g8 8gt
nnoremap g9 :tablast <enter>
" very usefull ailiases:
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev te tabedit
cnoreabbrev rename Rename
cnoreabbrev rn Rename
cnoreabbrev x Explor
cnoreabbrev explor Explor
cnoreabbrev xx tabedit `pwd`
cnoreabbrev tabmerge Tabmerge
cnoreabbrev tm Tabmerge
" make resizing windows much easier:
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
	map > <C-W>>
	map < <C-W><
endif
" make scrolling horizontally easier and more intutive:
map <C-L> zl " Scroll 20 characters to the right
map <C-H> zh " Scroll 20 characters to the left
" make plugin installations easy and use github-plugins from ~/.vim/bundle:
execute pathogen#infect()
" make reading help documents easier:
Helptags
" make change git disply easier to type made by gitgutter plugin
cnoreabbrev git GitGutterEnable
cnoreabbrev nogit GitGutterDisable
"GitGutterToggle
cnoreabbrev gitsigns GitGutterSignsEnable
cnoreabbrev nogitsigns GitGutterSignsDisable
"GitGutterSignsToggle
cnoreabbrev gitbg GitGutterLineHighlightsEnable
cnoreabbrev nogitbg GitGutterLineHighlightsDisable
"GitGutterLineHighlightsToggle
" keyboard maps to aviod typing in hebrew:
map ק e
map ר r
map א t
map ט y
map ו u
map ן i
map ם o
map פ p
map ש a
map ד s
map ג d
map כ f
map ע g
map י h
map ח j
map ל k
map ך l
map ף ;
map ז z
map ס x
map ב c
map ה v
map נ b
map מ n
map צ m
map ת ,
map ץ .
