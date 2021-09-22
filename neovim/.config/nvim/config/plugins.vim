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
        execute "!curl -fLo " . s:install_dir . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    endif

    if has('nvim')
        call plug#begin("~/.config/nvim/plugged")
    else
        call plug#begin("~/.vim/plugged")
    endif
endif

" Additional language support
Plug 'vim-python/python-syntax'
Plug 'chrisbra/csv.vim'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'bfrg/vim-cpp-modern'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'ocaml/vim-ocaml'
Plug 'CrossR/vim-fhicl'

Plug 'tpope/vim-fugitive'
Plug 'Lenovsky/nuake'

Plug 'mhinz/vim-signify'
Plug 'bronson/vim-trailing-whitespace'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'CrossR/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'airblade/vim-rooter'
Plug 'artnez/vim-wipeout'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'

" Writing notes/LaTeX plugins
Plug 'lervag/wiki.vim', { 'on': ['WikiIndex', 'WikiJournal'] }
Plug 'CrossR/vim-code-notes',
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'CrossR/quicktex', { 'for': ['tex', 'markdown'] }
Plug 'CrossR/vim-remarkjs', { 'on': 'RemarkPreview' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

if has('nvim')
    Plug 'CrossR/nvim_diary_template', { 'do': ':UpdateRemotePlugins', 'for': 'markdown' }
else
    Plug 'CrossR/nvim_diary_template', { 'for': 'markdown' }
    Plug 'CrossR/vim-hug-neovim-rpc'
    Plug 'roxma/nvim-yarp'
endif

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

call plug#end()

