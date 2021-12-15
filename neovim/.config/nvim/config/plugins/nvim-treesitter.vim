" Treesitter Config

if !has('nvim')
    finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
}
require('spellsitter').setup()
EOF
