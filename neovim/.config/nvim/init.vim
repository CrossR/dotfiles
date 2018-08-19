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
set softtabstop=4         " A tab feels like 4 spaces.
set shiftwidth=4          " This affects >> and <<, to make them move by 4 spaces.
set expandtab             " Insert spaces not tabs

set list                  " Show all whitespace
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

set ignorecase            " Ignore case for searching
set smartcase             " Use smart cases for search
set lazyredraw            " No redraws in macros

set undofile

if !exists('g:gui_oni')
    set laststatus=2      " Needed for AirLine to show.
else
    set laststatus=0      " Disable any status bar, since we are inside Oni.
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

" File type specific config

" Run Python files on F9

augroup PythonConfig
    autocmd!
    autocmd FileType python nnoremap <buffer> <F9> <cmd>exec '!python' shellescape(@%,1)<CR>
augroup END

" Latex Config
" Run Count on F8, Compile on F9 and show Contents buffer on F10
" Also set spell checking and wrapping of text.

augroup TexConfig
    autocmd!
    autocmd FileType tex nnoremap <buffer> <F8> <cmd>VimtexCountWords<CR>
    autocmd FileType tex nnoremap <buffer> <F9> <cmd>VimtexCompile<CR>
    autocmd FileType tex nnoremap <buffer> <F10> <cmd>VimtexTocToggle<CR>
    autocmd FileType tex setlocal spell spelllang=en_gb " Spellchecking for .tex only
    autocmd FileType tex setlocal textwidth=80          " Wrap at 80 cols in .tex files.
    autocmd FileType tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
augroup END

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
vnoremap . <cmd>norm.<CR>
command! RootSave <cmd>execute '<cmd>silent w !sudo tee % >/dev/null' | <cmd>edit
tnoremap <Esc> <C-\><C-n>
nnoremap <C-L> <cmd>nohlsearch<CR><C-L>

" Fix clumsy typing to quit

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wqa wqa

" Use Conda Env for Python

if has ('nvim') && has('win32')
    let venv_folder = $HOME . "/.virtualenvs/nvim-diary-template-py3.6"
    let g:python3_host_prog = venv_folder . "/Scripts/python.exe"
endif

" Terminal toggle setup
" Setup an array to store the relevant buf nums and last used term
" This is called by Oni since that stores an array of each terminal
" name and its associated command.

function! Term_toggle_setup(term_count) abort

    let g:term_buf = map(range(a:term_count), 0)
    let g:term_currently_open = map(range(a:term_count), 0)

    let g:last_term = ""
    let g:last_term_num = -1

endfunction

" Terminal open
" Open the releavant terminal, passed to nvim by Oni.
" If currently in the terminal, close it.
" Otherwise, attempt to swap to it and open it if that fails.

function! Term_open(term_num, term) abort

    let term_already_open = g:term_currently_open[a:term_num]

    if g:term_buf[a:term_num] == bufnr("")
        setlocal bufhidden=hide
        hide
        let g:term_currently_open[a:term_num] = 0
    elseif term_already_open == 0
        botright 15new
        let g:term_currently_open[a:term_num] = 1

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

function! Term_toggle() abort

    " If the command wasn't called since we aren't
    " in Oni, only setup bash.
    if !exists('g:term_buf')
        call Term_toggle_setup(1)
        call Term_open(0, 'bash')
        return
    endif

    let currently_in_terminal = index(g:term_buf, bufnr(""))

    let other_term_index = index(g:term_currently_open, 1)
    let last_term_exists = g:last_term_num != -1 && g:last_term != ""

    if currently_in_terminal != -1
        setlocal bufhidden=hide
        hide
        let g:term_currently_open[currently_in_terminal] = 0
    elseif last_term_exists && other_term_index == -1
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

if !has('win32')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/AppData/Local/nvim/plugged')
endif

if !exists('g:gui_oni')
    " Bottom status bar, not needed for Oni.
    Plug 'itchyny/lightline.vim'

    " Fuzzy file finder
    Plug 'ctrlpvim/ctrlp.vim'

    " Tab complete
    Plug 'ervandew/supertab'

    " Show line indentation
    Plug 'yggdroot/indentLine'

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

" Better sessions
Plug 'tpope/vim-obsession'

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

" Autogen Python docstrings
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }

" VimWiki, Helpers and Diary Generation
Plug 'vimwiki/vimwiki'
Plug 'CrossR/nvim_diary_template', { 'do': ':UpdateRemotePlugins' }

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Python Formatting
Plug 'ambv/black'

call plug#end()

" Fugitive
" Add leader bindings

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>

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

if !exists('g:gui_oni')
    let g:indentLine_enabled = 0
    let g:indentLine_leadingSpaceEnabled = 1
    let g:indentLine_leadingSpaceChar= '·'
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

" VimWiki

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let default_wiki = {}

let default_wiki.path = $GIT_DEFAULT_DIR . "/wiki/docs"
let default_wiki.syntax = 'markdown'
let default_wiki.ext = ".md"
let default_wiki.auto_tags = 1
let default_wiki.list_margin = 0

let g:vimwiki_list = [default_wiki]
let g:vimwiki_conceallevel = 0
let g:vimwiki_folding = 'custom'

let g:wiki_scratch_open = 0
let g:wiki_scratch_buf_nr = 0

" Set all the headers to different colours.
" Uses highlight groups that should be bound in most colour schemes.
highlight link VimwikiHeader1 Statement
highlight link VimwikiHeader2 Identifier
highlight link VimwikiHeader3 Type
highlight link VimwikiHeader4 Constant
highlight link VimwikiHeader5 Include
highlight link VimwikiHeader6 Title

function! Wiki_Scratch() abort

    if g:wiki_scratch_open == 1
        if g:wiki_scratch_buf_nr == bufnr("")
            setlocal bufhidden=hide
            hide
            let g:wiki_scratch_open = 0
        endif
    elseif g:wiki_scratch_open == 0

        botright 15new
        let g:wiki_scratch_open = 1

        try
            exec "buffer " . g:wiki_scratch_buf_nr
        catch
            exec 'edit ' . g:vimwiki_list[0].path . "/Temporary Notes.md"
            let g:wiki_scratch_buf_nr = bufnr("")
        endtry
    endif

endfunction

nnoremap <leader>sw <Plug>VimwikiUISelect
nnoremap <leader>ws :call Wiki_Scratch()<CR>

augroup WikiConfig
    autocmd!
    autocmd FileType vimwiki nnoremap <buffer> <leader>wt :VimwikiTable<space>
    autocmd FileType vimwiki nnoremap <buffer> <leader>wc :VimwikiTOC<CR>

    autocmd FileType vimwiki nmap <F9> i<C-R>=strftime("%H:%M %p")<CR>
    autocmd FileType vimwiki imap <F9> <C-R>=strftime("%H:%M %p")<CR>

    autocmd FileType vimwiki nmap <F10> i<C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>
    autocmd FileType vimwiki imap <F10> <C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>

    autocmd FileType vimwiki setlocal spell spelllang=en_gb " Spellchecking for VimWiki only
    autocmd FileType vimwiki setlocal textwidth=88          " Wrap at 88 cols in VimWiki files.
augroup END

" Nvim Diary config

let g:nvim_diary_template#notes_path = $GIT_DEFAULT_DIR . "/wiki/docs/"
let g:nvim_diary_template#config_path = $GIT_DEFAULT_DIR . "/wiki/config/"
let g:nvim_diary_template#auto_generate_diary_index = 1
let g:nvim_diary_template#google_cal_name = 'NVim Notes'
let g:nvim_diary_template#repo_name = 'CrossR/wiki'
let g:nvim_diary_template#user_name = 'CrossR'
let g:nvim_diary_template#calendar_filter_list = ['Holidays in United Kingdom']

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

" <TAB>: completion.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

if !exists('g:deoplete#sources')
  let g:deoplete#sources = {}
endif

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer']
let g:deoplete#sources.vimwiki = ['gh_label', 'gh_repo', 'file', 'vw_tag', 'omni']

augroup DisableDeoplete
    autocmd!
    autocmd FileType typescript let b:deoplete_disable_auto_complete = 1
    autocmd FileType javascript let b:deoplete_disable_auto_complete = 1
    autocmd FileType python let b:deoplete_disable_auto_complete = 1
augroup END

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#omni#input_patterns.vimwiki = [':']

" Black formatter

autocmd BufWritePost *.py execute ':Black'
let g:black_virtualenv = venv_folder
