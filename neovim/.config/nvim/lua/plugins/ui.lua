-- Gruvbox
return {{
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local colors = require("gruvbox").palette
        require("gruvbox").setup({
            overrides = {
                SignColumn = {
                    bg = colors.dark0
                },
                DiffDelete = {
                    fg = colors.red,
                    bg = colors.dark0,
                    reverse = false
                },
                DiffAdd = {
                    fg = colors.green,
                    bg = colors.dark0,
                    reverse = false
                },
                DiffChange = {
                    fg = colors.yellow,
                    bg = colors.dark0,
                    reverse = false
                },
                DiffText = {
                    fg = colors.orange,
                    bg = colors.dark0,
                    reverse = false
                },
                SpellBad = {
                    link = "WarningMsg"
                },
                SpellCap = {
                    link = "ModeMsg"
                },
                SpellLocal = {
                    link = "ModeMsg"
                },
                SpellRare = {
                    link = "Question"
                },

            }
        })
        vim.cmd.colorscheme("gruvbox")
    end
}, {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "gruvbox_dark"
            }
        })
    end
}, {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    config = function()
        require("gitsigns").setup({
            signs = {}
        })
    end
}, {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", ":Git<CR>")
    end,
    cmd = "Git"
}}
