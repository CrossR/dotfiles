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

set spelllang=en_gb

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=fold:\ 
set display+=lastline
set formatoptions+=j
set sessionoptions-=options

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

set laststatus=0
set noswapfile

if exists('&inccommand')
    set inccommand=nosplit
endif

" Setup Python Env
if has ('nvim') && has('win32')
    let g:venv_folder = $HOME . "/.virtualenvs/nvim-diary-template-py3.7"
    let g:python3_host_prog = g:venv_folder . "/Scripts/python.exe"
elseif has('nvim') && has('unix')
    if (system('uname') =~ "darwin")
        let g:python3_host_prog = $HOME . "/.virtualenvs/nvim-diary-template--Z3Z6Czd-py3.8/bin/python"
    else
        let g:python3_host_prog = $HOME . "/.python/virtualenvs/nvim-diary-template-py3.6/bin/python"
    endif
endif

" Highlight yanks
augroup HighlightYanks
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" Change spell highlights by linking to some more basic highlights.
" Also only enable spelling in buffers we are editing, rather
" than globally.
function! Change_Spell_Highlights() abort
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
    autocmd BufEnter * call Change_Spell_Highlights()
    autocmd InsertEnter * setlocal spell
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

" Remove line numbers from the terminal in neovim.
if has ('nvim')
    augroup TerminalFix
        autocmd!
        autocmd TermOpen * setlocal nonumber norelativenumber nospell
    augroup END
endif
