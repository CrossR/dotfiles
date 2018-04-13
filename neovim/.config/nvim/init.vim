" These are already taken care of already in Oni
if !exists('g:gui_oni')
    syntax on             " Syntax highlighting
endif

if exists('g:gui_oni')
    set noswapfile
    set hidden
endif

set number                " Line numbers
set incsearch             " Incremental search

                          " Sort out splits
set splitright            " Open vsplits on the right
set splitbelow            " Open splits on the bottom

                          " Deal with GUI duplications
set noshowmode            " Stop mode text showing.
set noshowcmd             " Disable the CMD line
set noruler               " Disable the line ruler

                          " Sort out Tabs
filetype plugin indent on " Add indentation as needed.
set tabstop=4             " A tab is 4 spaces.
set shiftwidth=4          " This affects >> and <<, to make them move by 4 spaces.
set expandtab             " Insert spaces not tabs

set list                  " Show all whitespace
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

set ignorecase            " Ignore case for searching
set smartcase             " Use smart cases for search
set lazyredraw            " No redraws in macros

if !exists('g:gui_oni')
    set laststatus=2      " Needed for AirLine to show.
else
    set laststatus=0      " Disable any status bar, since we are inside Oni.
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

autocmd FileType tex setlocal spell spelllang=en_gb " Spellchecking for .tex only
autocmd FileType tex setlocal textwidth=80          " Wrap at 80 cols in .tex files.

" Set the Vim spell file location

if !exists('g:gui_oni')
    set spellfile=~/.nvim/spell/en.utf-8.add
else
    set spellfile=~/AppData/Local/nvim/spell/en.utf-8.add
endif

" File building remapping

" Run Python files on F9

autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>

" Run Latex PDF make on F9, and word count on F8

autocmd FileType tex nnoremap <buffer> <F8> :VimtexCountWords<CR>
autocmd FileType tex nnoremap <buffer> <F9> :VimtexCompile<CR>
autocmd FileType tex nnoremap <buffer> <F10> :VimtexTocToggle<CR>

" Clipboard Setup

if has ('nvim') && !exists('g:gui_oni')
    runtime! python_setup vim
    set clipboard+=unnamedplus
endif

let g:highlightedyank_highlight_duration = 200

" Remaps

nmap j gj
nmap k gk
let mapleader = ","  " Set leader to ,
vnoremap . :norm.<CR>
command! RootSave :execute ':silent w !sudo tee % >/dev/null' | :edit
tnoremap <Esc> <C-\><C-n>
nnoremap <C-L> :nohlsearch<CR><C-L>

" Fix clumsy typing to quit

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wqa wqa

" Terminal toggle setup
" Setup an array to store the relevant buf nums and last used term
" This is called by Oni since that stores an array of each terminal
" name and its associated command.

function! Term_toggle_setup(term_count)

    let g:term_buf = map(range(a:term_count), 0)

    let g:last_term = ""
    let g:last_term_num = -1

endfunction

" Terminal open
" Open the releavant terminal, passed to nvim by Oni.
" If currently in the terminal, close it.
" Otherwise, attempt to swap to it and open it if that fails.

function! Term_open(term_num, term)

    if g:term_buf[a:term_num] == bufnr("")
        setlocal bufhidden=hide
        hide
    else
        botright 15new

        try
            exec "buffer ".g:term_buf[a:term_num]
        catch
            exec 'terminal ' . a:term
            let g:term_buf[a:term_num] = bufnr("")
        endtry
    endif

    let g:last_term = a:term
    let g:last_term_num = a:term_num

endfunction

" Terminal toggle
" Hide the currently active terminal,
" or show the last used one.

function! Term_toggle()

    " If the command wasn't called since we aren't
    " in Oni, only setup bash.
    if !exists('g:term_buf')
        call Term_toggle_setup(1)
        call Term_open(0, 'bash')
        return
    endif

    let buf_index = index(g:term_buf, bufnr(""))

    if buf_index != -1
        setlocal bufhidden=hide
        hide
    elseif g:last_term_num != -1 && g:last_term != ""
        call Term_open(g:last_term_num, g:last_term)
    endif

endfunction

nnoremap <leader>, :call Term_toggle()<CR>

" Install plug.vim automaticaly if possible.

let vimplug=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug) && !has('win32')
    if !executable("curl")
        echoerr "vim-plug will need to be manually installed, as curl is not available."
        execute "q!"
    endif
    echo "Installing vim-plug..."
    echo  ""
    silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugin install location and list of plugins

if !exists('g:gui_oni')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/AppData/Local/nvim/plugged')
endif

if !exists('g:gui_oni')
    " Bottom status bar, not needed for Oni.
    Plug 'itchyny/lightline.vim'

    " Fuzzy file finder
    Plug 'ctrlpvim/ctrlp.vim'
endif

" Git Plugin
Plug 'tpope/vim-fugitive'

" Nicer commenting using gcc
Plug 'tpope/vim-commentary'

" Change around things
Plug 'tpope/vim-surround'

" Repeat addons with .
Plug 'tpope/vim-repeat'

" Bracket mappings
Plug 'tpope/vim-unimpaired'

" Async linting
Plug 'w0rp/ale'

" Language packs
Plug 'sheerun/vim-polyglot'

" Vim TeX
Plug 'lervag/vimtex', { 'for': 'tex' }

" Add back --remote, needed for VimTeX
Plug 'mhinz/neovim-remote', { 'for': 'tex' }

" Git diff in gutter
Plug 'airblade/vim-gitgutter'

" Highlight trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" Align text on a symbol using ga
Plug 'junegunn/vim-easy-align'

" Jump motion using s
Plug 'justinmk/vim-sneak'

" Briefly highlight the yanked region
Plug 'machakann/vim-highlightedyank'

" Add additional text objects
Plug 'wellle/targets.vim'

" Show line indentation
Plug 'yggdroot/indentLine'

" Tab complete
Plug 'ervandew/supertab'

" Autogen Python docstrings
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }

call plug#end()

" Sneak Options
" Rebind f/t to use a 1 char sneak.
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" CtrlP

if !exists('g:gui_oni')
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endif

" Polygot

let g:polyglot_disabled = ['latex']

" IndentLine

if exists('g:gui_oni')
    " IndentLines, but not in Oni
    let g:indentLine_color_term = 239
    let g:indentLine_enabled = 0
    let g:indentLine_leadingSpaceEnabled = 1
    let g:indentLine_leadingSpaceChar= '.'
endif

" Mappings for EasyAlign
" Interactive EasyAlign for Visual Mode, motions and text objects

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Vim Tex Options

let g:tex_flavor = 'latex'
let g:tex_conceal = ""
let g:vimtex_latexmk_progname = 'nvr'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=0',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Get Oni to use SumatraPDF as the VimTeX viewer

if exists('g:gui_oni')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif
