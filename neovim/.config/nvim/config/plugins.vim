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
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'lervag/vimtex'
Plug 'CrossR/vim-fhicl'

" Tools
Plug 'tpope/vim-fugitive'
Plug 'Lenovsky/nuake'
Plug 'dstein64/vim-startuptime'

" UI
Plug 'mhinz/vim-signify'
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Helpers
Plug 'airblade/vim-rooter'
Plug 'artnez/vim-wipeout'
Plug 'bronson/vim-trailing-whitespace'

" Extend vim-isms
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'

" Writing notes/LaTeX plugins
Plug 'lervag/wiki.vim', { 'on': ['WikiIndex', 'WikiJournal'] }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'CrossR/vim-remarkjs', { 'on': 'RemarkPreview' }
Plug 'CrossR/nvim_diary_template', { 'do': ':UpdateRemotePlugins', 'for': 'markdown' }

" Add back --remote, needed for VimTeX
Plug 'mhinz/neovim-remote', { 'for': 'tex' }

" LSP
Plug 'neovim/nvim-lspconfig'

" Nvim-Cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-copilot'
Plug 'onsails/lspkind-nvim'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'github/copilot.vim'

" Treesitter + Colour scheme for it
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'lewis6991/spellsitter.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

