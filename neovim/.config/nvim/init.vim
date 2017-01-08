"Toggles

set showmatch "Matching Brackets
set ignorecase "Case Insensitive Matching
set smartcase "Smart Case Matching
set incsearch "Incremental Search
set mouse=a "Mouse Usage
set number "Line Numbers
syntax on "Syntax Highlighting
set laststatus=2 "Needed for AirLine to show
autocmd FileType tex setlocal spell spelllang=en_gb "Spellchecking for .tex only
set spellfile=~/.nvim/spell/en.utf-8.add "Vim spell file
set scrolloff=4 "Number of lines to move around on scrolling
set tabstop=4 "Indent every 4 cols
set shiftwidth=4 "Indents are 4 spaces
set smartindent "Smart Indentation
set expandtab "Spaces not tabs
set softtabstop=4 "Delete indents

"File building remapping
"Run Python files on F9
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>
"Run Latex PDF make on F9, and word count on F8
autocmd FileType tex nnoremap <buffer> <F8> :VimtexWordCount<CR>
autocmd FileType tex nnoremap <buffer> <F9> :VimtexCompileToggle<CR>
autocmd FileType tex nnoremap <buffer> <F10> :VimtexTocToggle<CR>
let g:tex_flavor = 'latex'

"Include QT in Syntastic
let g:syntastic_cpp_include_dirs = ['/usr/include/qt4/QtGui']

" Highlight over 80 cols in red
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.\+/

"Clipboard

if has ('nvim')
	runtime! python_setup vim
endif
if has ('nvim')
	set clipboard+=unnamedplus
endif

"Remaps

:nmap j gj
:nmap k gk
:let mapleader = ","
:vnoremap . :norm.<CR>

"Airline

let g:airline_powerline_fonts = 1 

if ! has ('gui_running')
		set ttimeoutlen=10
		augroup FastEscape
				autocmd!
				au InsertEnter * set timeoutlen=0
				au InsertLeave * set timeoutlen=1000
		augroup END
endif


"CtrlP

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Plug

call plug#begin('~/.nvim/plugged')

" Add new plugins here

"This is the bottom bar 
Plug 'bling/vim-airline'
"This is the Git Plugin
Plug 'tpope/vim-fugitive'
"Nicer commenting
Plug 'scrooloose/nerdcommenter'
"Change inside things
Plug 'tpope/vim-surround'
"Repeat Addons with .
Plug 'tpope/vim-repeat'
"Date Incrementing
Plug 'tpope/vim-speeddating'
"Syntax and Build"
Plug 'scrooloose/syntastic'
"File Finder"
Plug 'ctrlpvim/ctrlp.vim'
"Async Build
Plug 'benekastah/neomake'
"Vim TeX
Plug 'lervag/vimtex'

call plug#end()
