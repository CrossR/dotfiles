" General config

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
set softtabstop=4         " A tab feels like 4 spaces.
set shiftwidth=4          " This affects >> and <<, to make them move by 4 spaces.
set expandtab             " Insert spaces not tabs

set list                  " Show all whitespace
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set shortmess+=c          " Remove match x of y etc

set ignorecase            " Ignore case for searching
set smartcase             " Use smart cases for search
set lazyredraw            " No redraws in macros

set undofile
set hidden

if !exists('g:gui_oni')
    set laststatus=2      " Needed for AirLine to show.
    syntax on             " Syntax highlighting
else
    set laststatus=0      " Disable any status bar, since we are inside Oni.
    set noswapfile        " No swap files, since we are on Windows most likely.
endif

if exists('&inccommand')
    set inccommand=nosplit
endif

" Set the Vim undo and spell file location after checking the relevant
" folders exist first.
function! Check_folder_exists(folder_name) abort
    let full_folder_path = expand(a:folder_name)

    if !isdirectory(full_folder_path)
        call mkdir(full_folder_path)
    endif
endfunction

if !has('win32')
    call Check_folder_exists("~/.config/nvim")
    call Check_folder_exists("~/.config/nvim/spell")
    call Check_folder_exists("~/.config/nvim/undodir")
    call Check_folder_exists("~/.config/nvim/sessions")

    set spellfile=~/.config/nvim/spell/en.utf-8.add
    set undodir=~/.config/nvim/undodir
else
    call Check_folder_exists("~/AppData/Local/nvim")
    call Check_folder_exists("~/AppData/Local/nvim/spell")
    call Check_folder_exists("~/AppData/Local/nvim/undodir")
    call Check_folder_exists("~/AppData/Local/nvim/sessions")

    set spellfile=~/AppData/Local/nvim/spell/en.utf-8.add
    set undodir=~/AppData/Local/nvim/undodir
endif

" Clipboard Setup
if has ('nvim') && !exists('g:gui_oni')
    runtime! python_setup vim
    set clipboard+=unnamedplus
endif

" Setup Python Env
if has ('nvim') && has('win32')
    let g:venv_folder = $HOME . "/.virtualenvs/nvim-diary-template-py3.6"
    let g:python3_host_prog = g:venv_folder . "/Scripts/python.exe"
elseif has('nvim') && !has('win32')
    let g:python3_host_prog = expand($PYTHONPATH) . '/python'
endif

" Fix spell highlights in Oni.
function! Sort_Spell_Highlights() abort

    if exists('g:gui_oni')
        highlight clear SpellBad
        highlight clear SpellCap
        highlight clear SpellLocal
        highlight clear SpellRare

        highlight link SpellBad WarningMsg
        highlight link SpellCap ModeMsg
        highlight link SpellLocal ModeMsg
        highlight link SpellRare Question
    endif

endfunction

if exists('g:gui_oni')
    augroup FixSpelling
        autocmd!
        autocmd BufEnter * call Sort_Spell_Highlights()
    augroup END
endif

" Save as root.
command! RootSave <cmd>execute '<cmd>silent w !sudo tee % >/dev/null' | <cmd>edit

