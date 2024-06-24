-- General
vim.opt.number = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.spell = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.shortmess:append("c")
vim.opt.conceallevel = 0
vim.opt.virtualedit = "block"
vim.opt.backspace = "indent,eol,start"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.lazyredraw = true
vim.opt.wildmenu = true
vim.opt.autoread = true

vim.opt.undofile = true
vim.opt.history = 10000
vim.opt.tabpagemax = 50
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.wrap = false

vim.opt.spelllang = "en_gb"

vim.opt.list = true
vim.opt.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·"
vim.opt.fillchars =
    "vert:│,fold:·,eob: ,msgsep:‾,foldopen:▾,foldsep:│,foldclose:▸"
vim.opt.display = "lastline"
vim.opt.formatoptions:append("j")
vim.opt.sessionoptions:remove("options")

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.opt.laststatus = 3
vim.opt.swapfile = false

vim.opt.inccommand = "nosplit"

-- Highlight on yank
vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
augroup END
]])

-- Autochange working directory when in insert mode
vim.cmd([[
augroup AutoChangeWorkingDirectory
  autocmd!
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
augroup END
]])

-- No line numbers in terminal
vim.cmd([[
augroup TerminalFix
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber nospell
augroup END
]])
