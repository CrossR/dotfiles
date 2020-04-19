" General configuration
" Remember that hitting `K` on any of the options
" will open the help page for that option!

set number
set incsearch
set hlsearch

set splitright
set splitbelow

set noshowmode
set noshowcmd
set noruler

filetype plugin indent on
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab

set shortmess+=c
set complete-=i
set conceallevel=0
set virtualedit=block
set backspace+=indent,eol,start

set ignorecase
set smartcase
set lazyredraw
set wildmenu
set autoread

set undofile
set history=10000
set tabpagemax=50
set hidden
set mouse=a
set nowrap

set spell spelllang=en_gb

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=fold:\ 
set display+=lastline
set formatoptions+=j
set sessionoptions-=options

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

if !exists('g:gui_oni')
    set laststatus=2
    syntax on
else
    set laststatus=0
    set noswapfile
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
    if has('nvim')
        let s:base_folder = "~/.config/nvim"
    else
        let s:base_folder = "~/.vim"
    endif
else
    let s:base_folder = "~/AppData/Local/nvim"
endif

call Check_folder_exists(s:base_folder)
call Check_folder_exists(s:base_folder . "/spell")
call Check_folder_exists(s:base_folder . "/undodir")
call Check_folder_exists(s:base_folder . "/sessions")

let &spellfile = s:base_folder . "/spell/en.utf-8.add"
let &undodir = s:base_folder . "/undodir"

" Setup Python Env
if has ('nvim') && has('win32')
    let g:venv_folder = $HOME . "/.virtualenvs/nvim-diary-template-py3.7"
    let g:python3_host_prog = g:venv_folder . "/Scripts/python.exe"
elseif has('nvim') && has('unix')
    if (system('uname') =~ "darwin")
        let g:python3_host_prog = $HOME . "/.virtualenvs/nvim-diary-template--Z3Z6Czd-py3.7/bin/python"
    else
        let g:python3_host_prog = $HOME . "/.python/virtualenvs/nvim-diary-template-py3.6/bin/python"
    endif
endif

" Fix spell highlights by linking to an obvious syntax class.
" Just avoids issues when terms/tmux/anything isn't happy with
" displaying bold characters etc.
function! Sort_Spell_Highlights() abort
        highlight clear SpellBad
        highlight clear SpellCap
        highlight clear SpellLocal
        highlight clear SpellRare

        highlight link SpellBad WarningMsg
        highlight link SpellCap ModeMsg
        highlight link SpellLocal ModeMsg
        highlight link SpellRare Question
endfunction

augroup FixSpelling
    autocmd!
    autocmd BufEnter * call Sort_Spell_Highlights()
augroup END

" Save as root.
command! RootSave :execute ':silent w !sudo tee % >/dev/null' | :edit

" Automatically swap the current working directory.
" However, only in insert mode so we maintain the project wide directory
" normally.
augroup AutoChdirHack
    autocmd!
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
augroup END

" Tidy up the colour scheme when on SSH.
" desert seems to be similar to the default, without the awful dark blue
" comments.
if $SSH_CONNECTION
    colorscheme desert
endif

" Remove line numbers from the terminal in neovim.
if has ('nvim')
    augroup TerminalFix
        autocmd!
        autocmd TermOpen * setlocal nonumber norelativenumber nospell
    augroup END
endif

" Set the shell variable for vim, so that we can use the WSL terminal.
" The other terminals can still be used with :term cmd etc.
if has("win32") && ! has('nvim')
    set shell=C:\\Windows\\Sysnative\\wsl.exe
    set shellpipe=|
    set shellredir=>
    set shellcmdflag=
endif
