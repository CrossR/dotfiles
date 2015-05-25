"Toggles

set showmatch "Matching Brackets
set ignorecase "Case Insensitive Matching
set smartcase "Smart Case Matching
set incsearch "Incremental Search
set mouse=a "Mouse Usage
set number "Line Numbers
set smartindent "Smart Indentation
syntax on "Syntax Highlighting
set laststatus=2 "Needed for AirLine to show
autocmd FileType tex setlocal spell spelllang=en_gb "Spellchecking for .tex only
set spellfile=~/.vim/spell/en.utf-8.add "Vim spell file

set tabstop=4 "Tabstop = 4. Expand Tab for spaces instead of tab. Shiftwidth for spaces inserted
set shiftwidth=4

"File building remapping
"Run Python files on F9
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>
"Run Latex PDF make on F9, and word count on F8
autocmd FileType tex nnoremap <buffer> <F9> :w <enter> :exec '!latexmk -pdf -silent % > /dev/null' shellescape(@%,1)<CR><CR>
autocmd FileType tex nnoremap <buffer> <F8> :w !detex \| wc -w<CR>

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
"Move between camel case as seperate words
:nmap w ,w
:nmap b ,b
:nmap e ,e
:let mapleader = ","

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


"NerdFile

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree  | endif

"Plug

call plug#begin('~/.nvim/plugged')

" Add new plugins here

"This is the bottom bar 
Plug 'bling/vim-airline'
"This is the Git Plugin
Plug 'tpope/vim-fugitive'
"File Tree Browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
"Nicer commenting
Plug 'scrooloose/nerdcommenter'
"Move between words in camelcase
Plug 'bkad/CamelCaseMotion'
"Change inside things"
Plug 'tpope/vim-surround'
"Syntax and Build"
Plug 'scrooloose/syntastic'
"File Finder"
Plug 'kien/ctrlp.vim'

call plug#end()
