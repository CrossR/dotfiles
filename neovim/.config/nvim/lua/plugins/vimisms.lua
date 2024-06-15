-- Basic Vim-isms config
return {
    {
        "justinmk/vim-sneak",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("", "f", "<Plug>Sneak_f", {
                silent = true,
            })
            vim.keymap.set("", "F", "<Plug>Sneak_F", {
                silent = true,
            })
            vim.keymap.set("", "t", "<Plug>Sneak_t", {
                silent = true,
            })
            vim.keymap.set("", "T", "<Plug>Sneak_T", {
                silent = true,
            })
        end,
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
        version = false,
        config = function()
            require("mini.surround").setup()
            require("mini.align").setup()
            require("mini.trailspace").setup()

            -- Create an alias for MiniTrailspace.trim()
            vim.cmd("command! -nargs=0 FixWhitespace :lua require('mini.trailspace').trim()")
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
