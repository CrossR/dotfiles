" gruvbox

if exists('g:gui_oni')
    finish
endif

set termguicolors
set background=dark

lua << EOF
vim.g.gruvbox_sign_column = "bg0"
vim.cmd("colorscheme gruvbox")
EOF
