set number
set noswapfile
set smartcase

set splitright
set splitbelow

" Default tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set noshowmode
set noruler
set laststatus=2
set noshowcmd

set list
set listchars=trail:·

" Helpers for command mode
" %% for current buffer file name
" :: for current buffer file path
cnoremap %% <C-R>=fnameescape(expand('%'))<CR>
cnoremap :: <C-R>=fnameescape(expand('%:p:h'))<CR>/

" Make Control+nav keys functionality in insert mode
inoremap <expr> <C-a> pumvisible() ? "<Esc>A" : "<C-o>A"
inoremap <expr> <C-b> pumvisible() ? "<Esc>bi" : "<C-o>b"
inoremap <expr> <C-l> pumvisible() ? "<Esc>la" : "<C-o>a"

let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'

"Autorun Linters
autocmd! BufWritePost * Neomake

"Run Python Code
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>

colorscheme onedark
match Error /\%81v.\+/

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'bkad/CamelCaseMotion'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'

call plug#end()
