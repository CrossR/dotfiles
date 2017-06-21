let inOni=g:gui_oni

"This should be taken care of already in Oni
if ! (inOni)
    set mouse=a "Mouse Usage
    syntax on "Syntax Highlighting
endif

if (inOni)
    colorscheme onedark

    set noswapfile

    set noshowmode
    set noruler
    set noshowcmd

    set list
    set listchars=tail:.

    set splitright
    set splitbelow

endif

set number "Line Numbers
set incsearch "Incremental Search

"Sort out Tabs
set tabstop=4 "Indent every 4 cols
set shiftwidth=4 "Indents are 4 spaces
set softtabstop=4 "Delete indents
set expandtab "Spaces not tabs
set smartindent "Smart Indentation

set scrolloff=4 "Number of lines to move around on scrolling

set laststatus=2 "Needed for AirLine to show
autocmd FileType tex setlocal spell spelllang=en_gb "Spellchecking for .tex only
set spellfile=~/.nvim/spell/en.utf-8.add "Vim spell file

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
match Error /\%80v.\+/

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
command RootSave :execute ':silent w !sudo tee % >/dev/null' | :edit

"Map to CamelCase motions
:map <silent> w <Plug>CamelCaseMotion_w
:map <silent> b <Plug>CamelCaseMotion_b
:map <silent> e <Plug>CamelCaseMotion_e
:map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

"Fix clumsy typing to quit
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q

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

"IndentLines

let g:indentLine_color_term = 239
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar= '.'

"Plug Install

let vimplug=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug) && !(inOni)
    if !executable("curl")
        echoerr "vim-plug will need to be manually installed, as curl is not available."
        execute "q!"
    endif
    echo "Installing vim-plug..."
    echo  ""
    silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"Plugin install

call plug#begin('~/.config/nvim/plugged')

"This is the bottom bar
Plug 'itchyny/lightline.vim'
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
"Tab Complete
Plug 'ervandew/supertab'
"CamelCase Motions
Plug 'bkad/CamelCaseMotion'
"Git diff in gutter
Plug 'airblade/vim-gitgutter'
"Highlight trailing whitespace
Plug 'bronson/vim-trailing-whitespace'
"Show line indentation
Plug 'yggdroot/indentLine'

call plug#end()
