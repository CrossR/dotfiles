return {{
    "justinmk/vim-sneak",
    config = function()
        vim.keymap.set("", "f", "<Plug>Sneak_f", {
            silent = true
        })
        vim.keymap.set("", "F", "<Plug>Sneak_F", {
            silent = true
        })
        vim.keymap.set("", "t", "<Plug>Sneak_t", {
            silent = true
        })
        vim.keymap.set("", "T", "<Plug>Sneak_T", {
            silent = true
        })
    end
}, {
    "junegunn/vim-easy-align",
    config = function()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {
            noremap = false
        })
        vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {
            noremap = false
        })
    end,
    cmd = "EasyAlign"
}, {
    "airblade/vim-rooter",
    config = function()
        vim.g.rooter_silent_chdir = 1
        vim.g.rooter_change_directory_for_non_project_files = 'current'
    end
}, {"tpope/vim-surround"}, {"tpope/vim-repeat"}, {
    "artnez/vim-wipeout",
    on = "Wipeout"
}, {
    "bronson/vim-trailing-whitespace",
    on = "Trim"
}, {"wellle/targets.vim"}}
