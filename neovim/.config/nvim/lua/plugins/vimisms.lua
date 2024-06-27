-- Basic Vim-isms config
return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "airblade/vim-rooter",
        event = "VeryLazy",
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_change_directory_for_non_project_files = "current"
        end,
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        version = false,
        config = function()
            require("mini.surround").setup()
            require("mini.align").setup()
            require("mini.trailspace").setup()

            -- Create an alias for MiniTrailspace.trim()
            vim.cmd(
                "command! -nargs=0 FixWhitespace :lua require('mini.trailspace').trim()"
            )
        end,
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "artnez/vim-wipeout",
        cmd = "Wipeout",
    },
    {
        "wellle/targets.vim",
        event = "VeryLazy",
    },
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
}
