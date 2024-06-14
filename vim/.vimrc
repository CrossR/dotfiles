" Basic vim config
" Used on remote machines, so bare minimum for remote development.

set nocompatible

set number                " Line numbers.
set incsearch             " Incremental search.
set hlsearch              " Highlight matches

                          " Sort out splits.
set splitright            " Open vsplits on the right.
set splitbelow            " Open splits on the bottom.

                          " Sort out Tabs.
set softtabstop=4         " A tab feels like 4 spaces.
set shiftwidth=4          " This affects >> and <<, to make them move by 4 spaces.
set expandtab             " Insert spaces not tabs.

set list                  " Show all whitespace.
set encoding=utf-8        " Set encoding to utf-8
set listchars=tab:>-,extends:›,precedes:‹,nbsp:·,trail:·

let mapleader=","         " Set the leader key to comma
let localleader=","

set ignorecase            " Ignore case for searching.
set smartcase             " Use smart cases for search.

set undofile              " Store changes in an undo file.
set undodir=~/.vim/undodir
set hidden                " Don't dispose of buffers when unloaded.

set laststatus=2          " Needed for LightLine to show.
syntax on                 " Syntax highlighting

set mouse=a

function! Check_folder_exists(folder_name) abort
    let full_folder_path = expand(a:folder_name)

    if !isdirectory(full_folder_path)
        call mkdir(full_folder_path)
    endif
endfunction

call Check_folder_exists("~/.vim")
call Check_folder_exists("~/.vim/undodir")

" Finally, load a few basic plugins.
" Install vim-plug automatically if it doesn't exist.
" This is a one-liner from the vim-plug README.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins...
call plug#begin('~/.vim/plugged')
Plug 'CrossR/vim-fhicl'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

