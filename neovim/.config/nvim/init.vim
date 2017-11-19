"These are already taken care of already in Oni
if !exists('g:gui_oni')
    syntax on           " Syntax Highlighting
endif

if exists('g:gui_oni')
    colorscheme onedark " Outside of Oni, use the default terminal colourings.
    set noswapfile
endif

set number              " Line Numbers
set incsearch           " Incremental Search

                        " Deal with GUI Duplications
set noshowmode          " Stop INSERT mode text showing. We have a status bar.
set noshowcmd           " Disable the CMD line, shown in the status bar.
set noruler             " Disable the line ruler, its shown in the status bar.

                        " Sort out splits
set splitright          " Open VSplits on the Right
set splitbelow          " Open Splits on the Bottom

                        " Sort out Tabs
set tabstop=4           " A tab is 4 columns.
set shiftwidth=4        " This affects >> and <<, to make them move by 4 columns.
set softtabstop=4       " How many columns to insert when you hit tab.
set expandtab           " Insert spaces not tabs
set smartindent         " Smart Indentation
set list                " Show all Whitespace
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

set ignorecase          " Ignore case for searching
set smartcase           " Use smart cases for search

if !exists('g:gui_oni')
    set laststatus=2    " Needed for AirLine to show.
else
    set laststatus=0    " Disable any status bar, since we are inside Oni.
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

autocmd FileType tex setlocal spell spelllang=en_gb " Spellchecking for .tex only
if !exists('g:gui_oni')
    set spellfile=~/.nvim/spell/en.utf-8.add              " Vim spell file
else
    set spellfile=~/AppData/Local/nvim/spell/en.utf-8.add " Vim spell file
endif

"File building remapping

"Run Python files on F9
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%,1)<CR>

"Run Latex PDF make on F9, and word count on F8
autocmd FileType tex nnoremap <buffer> <F8> :VimtexCountWords<CR>
autocmd FileType tex nnoremap <buffer> <F9> :VimtexCompile<CR>
autocmd FileType tex nnoremap <buffer> <F10> :VimtexTocToggle<CR>
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_progname = 'nvr'

if exists('g:gui_oni')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

"Run HTML make on F8, View on F9 and Make all on F10.
autocmd FileType vimwiki nnoremap <buffer> <F8> :Vimwiki2HTMLBrowse<CR>
autocmd FileType vimwiki nnoremap <buffer> <F9> :Vimwiki2HTML<CR>
autocmd FileType vimwiki nnoremap <buffer> <F10> :VimwikiAll2HTML<CR>

" Highlight over 80 cols in red
match Error /\%80v.\+/

"Clipboard Setup

if has ('nvim')
    runtime! python_setup vim
endif

if has ('nvim')
    set clipboard+=unnamedplus
endif

"Remaps

:nmap j gj
:nmap k gk
:let mapleader = "," "Set leader to ,
:vnoremap . :norm.<CR>
command! RootSave :execute ':silent w !sudo tee % >/dev/null' | :edit
:tnoremap <Esc> <C-\><C-n>?\$<CR>

"Fix clumsy typing to quit

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wqa wqa

"CtrlP

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

if !exists('g:gui_oni')
    "IndentLines, but not in Oni
    let g:indentLine_color_term = 239
    let g:indentLine_enabled = 0
    let g:indentLine_leadingSpaceEnabled = 1
    let g:indentLine_leadingSpaceChar= '.'
endif

"Mappings for EasyAlign
"Interactive EasyAlign for Visual Mode, motions and text objects
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"Hard Mode
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 5

"Plug Install
let vimplug=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug) && !exists('g:gui_oni')
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

if !exists('g:gui_oni')
    "Bottom Status Bar, not needed for Oni.
    Plug 'itchyny/lightline.vim'
    "Fuzzy File Finder
    Plug 'ctrlpvim/ctrlp.vim'
    "Show line indentation
    Plug 'yggdroot/indentLine'
endif

"Git Plugin
Plug 'tpope/vim-fugitive'
"Nicer commenting
Plug 'tpope/vim-commentary'
"Change around things
Plug 'tpope/vim-surround'
"Repeat Addons with .
Plug 'tpope/vim-repeat'
"Date Incrementing
Plug 'tpope/vim-speeddating'
"Bracket Mappings
Plug 'tpope/vim-unimpaired'
"Async Linting
Plug 'w0rp/ale'
"Language Packs
Plug 'sheerun/vim-polyglot'
"Vim TeX
Plug 'lervag/vimtex', { 'for': 'tex' }
"Add Back --remote, needed for above
Plug 'mhinz/neovim-remote', { 'for': 'tex' }
"Tab Complete
Plug 'ervandew/supertab'
"Git diff in gutter
Plug 'airblade/vim-gitgutter'
"Highlight trailing whitespace
Plug 'bronson/vim-trailing-whitespace'
"Align text on a symbol
Plug 'junegunn/vim-easy-align'
"Wiki For Vim
Plug 'vimwiki/vimwiki'
"Jump motion
Plug 'justinmk/vim-sneak'
"Hard Mode (Time to kick those habits!)
Plug 'takac/vim-hardtime'
"Fancy startup screen
Plug 'mhinz/vim-startify'
"Briefly Highlight the Yanked Region
Plug 'machakann/vim-highlightedyank'
"Add additional text objects
Plug 'wellle/targets.vim'

call plug#end()
