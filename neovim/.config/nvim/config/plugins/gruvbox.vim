" gruvbox

if exists('g:gui_oni')
    finish
endif

set termguicolors
set background=dark

lua << EOF
  local colors = require("gruvbox").palette
  require("gruvbox").setup({
  overrides = {
      SignColumn = { bg = colors.dark0 },
      DiffDelete = { fg = colors.red, bg = colors.dark0, reverse = false },
      DiffAdd = { fg = colors.green, bg = colors.dark0, reverse = false },
      DiffChange = { fg = colors.yellow, bg = colors.dark0, reverse = false },
      DiffText = { fg = colors.orange, bg = colors.dark0, reverse = false },
      }
  })
  vim.cmd([[colorscheme gruvbox]])
EOF
