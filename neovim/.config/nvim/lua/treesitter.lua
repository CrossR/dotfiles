-- Neovim treesitter config

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "markdown", "markdown_inline" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
      enable = true
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
}
