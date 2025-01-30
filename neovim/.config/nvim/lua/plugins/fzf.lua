-- FZFLua Config
return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local actions = require("fzf-lua.actions")

            require("fzf-lua").setup({
                "telescope",
                winopts = { preview = { default = "bat" } },
                actions = {
                    files = {
                        ["ctrl-s"] = actions.file_split,
                        ["ctrl-v"] = actions.file_vsplit,
                        ["ctrl-t"] = actions.file_tabedit,
                        ["alt-q"] = actions.file_sel_to_qf,
                    },
                },
            })
        end,
        keys = {
            { "<c-p>", "<CMD>FzfLua files<CR>" },
            { "<c-f>", "<CMD>FzfLua grep_project<CR>" },
            { "<leader>b", "<CMD>FzfLua buffers<CR>" },
        },
    },
}
