" lualine

if exists('g:gui_oni')
    finish
endif

if !has('nvim')
    finish
endif

lua <<EOF
require('lualine').setup {
    options = {
        theme = 'gruvbox_dark'
    }
}
EOF
