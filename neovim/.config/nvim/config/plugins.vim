"Plugin Config

" Auto install vim-plug

if has('win32')
    let vimplug=expand('~/AppData/Local/nvim/autoload/plug.vim')

    if !filereadable(vimplug)
        echo "Installing vim-plug..."
        silent !powershell -Command "new-item \%LOCALAPPDATA\%/nvim/autoload -itemtype directory"
        silent !powershell -Command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', '\%LOCALAPPDATA\%/nvim/autoload/plug.vim')"
    endif

    call plug#begin('~/AppData/Local/nvim/plugged')
endif

if !has('win32')

    if has('nvim')
        let s:install_dir = "~/.config/nvim/autoload/plug.vim"
    else
        let s:install_dir = "~/.vim/autoload/plug.vim"
    endif

    let vimplug=expand(s:install_dir)

    if !filereadable(vimplug)
        if !executable("curl")
            echoerr "vim-plug will need to be manually installed, as curl is not available."
            execute "q!"
        endif
        echo "Installing vim-plug..."
        silent !\curl -fLo s:install_dir --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    if has('nvim')
        call plug#begin("~/.config/nvim/plugged")
    else
        call plug#begin("~/.vim/plugged")
    endif
endif

if !exists('g:gui_oni')
    " Bottom status bar, not needed for Oni.
    Plug 'itchyny/lightline.vim'

    " Fuzzy finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Set working folder
    Plug 'airblade/vim-rooter'

    " Show line indentation
    Plug 'yggdroot/indentLine'

    " Colourscheme
    Plug 'morhetz/gruvbox'

    " Tmux bingings
    Plug 'christoomey/vim-tmux-navigator'

    " Start screen
    Plug 'mhinz/vim-startify'
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

" Language packs
Plug 'sheerun/vim-polyglot'

" Vim TeX
Plug 'lervag/vimtex', { 'for': 'tex' }

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

" VimWiki, a personal wiki
Plug 'vimwiki/vimwiki'

" Write slides in MarkDown
Plug 'CrossR/vim-remarkjs', { 'on': 'RemarkPreview' }

" Focused writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Helpers for FHICL files
Plug 'CrossR/vim-fhicl'

" C++ Enhancments
Plug 'bfrg/vim-cpp-modern'

if has('nvim')
    " Add back --remote, needed for VimTeX
    Plug 'mhinz/neovim-remote', { 'for': 'tex' }
endif

if has('nvim')
    let s:has_features = has('timers') && has('nvim-0.2.0')
else
    let s:has_features = has('timers') && exists('*job_start') && exists('*ch_close_in')
endif

if s:has_features
    " Async linting
    Plug 'w0rp/ale'
endif

if has('python3') && has('nvim')
    " Diary templates with GitHub + GCal integration
    Plug 'CrossR/nvim_diary_template', { 'do': ':UpdateRemotePlugins', 'for': 'vimwiki' }

    " Autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " Python Formatting
    Plug 'ambv/black', { 'for': 'python' }

    if !has('win32')
        " Autocomplete for Python
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
    endif
endif

call plug#end()

