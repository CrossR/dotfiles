-- Gruvbox Config
return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local colors = require("gruvbox").palette
            require("gruvbox").setup({
                overrides = {
                    SignColumn = {
                        bg = colors.dark0,
                    },
                    DiffDelete = {
                        fg = colors.red,
                        bg = colors.dark0,
                        reverse = false,
                    },
                    DiffAdd = {
                        fg = colors.green,
                        bg = colors.dark0,
                        reverse = false,
                    },
                    DiffChange = {
                        fg = colors.yellow,
                        bg = colors.dark0,
                        reverse = false,
                    },
                    DiffText = {
                        fg = colors.orange,
                        bg = colors.dark0,
                        reverse = false,
                    },
                    SpellBad = {
                        link = "WarningMsg",
                    },
                    SpellCap = {
                        link = "ModeMsg",
                    },
                    SpellLocal = {
                        link = "ModeMsg",
                    },
                    SpellRare = {
                        link = "Question",
                    },
                },
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },
}
