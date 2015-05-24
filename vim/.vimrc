
filetype plugin indent on
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

if ! has ('gui_running')
		set ttimeoutlen=10
		augroup FastEscape
				autocmd!
				au InsertEnter * set timeoutlen=0
				au InsertLeave * set timeoutlen=1000
		augroup END
endif

set tabstop=4 "Tabstop = 4. Expand Tab for spaces instead of tab. Shiftwidth for spaces inserted
set shiftwidth=4

"Python
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>
autocmd FileType tex nnoremap <buffer> <F9> :w <enter> :exec '!latexmk -pdf -silent % > /dev/null' shellescape(@%,1)<CR><CR>
autocmd FileType tex nnoremap <buffer> <F8> :w !detex \| wc -w<CR>

highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.\+/

"Remaps

:nmap j gj
:nmap k gk
:let mapleader = ","

"Airline

let g:airline_powerline_fonts = 1 

"NerdFile

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree  | endif

"  NeoBundle Code.
if has ('vim_starting')
		if &compatible
				set nocompatible
		endif


		set runtimepath+=~/.vim/bundle/neobundle.vim

endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Add new plugins here
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
"NeoBundleInstall
"NeoBundleUpdate

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
