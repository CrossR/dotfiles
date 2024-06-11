-- FZFLua Config
return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local actions = require("fzf-lua.actions")

            local function file_edit_or_tab(selected, opts)
                if #selected > 1 then
                    return actions.file_tabedit(selected, opts)
                else
                    return actions.file_edit(selected, opts)
                end
            end

            require"fzf-lua".setup({
                "telescope",
                winopts = { preview = {default = "bat" } },
                files = { path_shorten=1 },
                actions = {
                    files = {
                        ["default"] = file_edit_or_tab,
                        ["ctrl-s"] = actions.file_split,
                        ["ctrl-v"] = actions.file_vsplit,
                        ["ctrl-t"] = actions.file_tabedit,
                        ["alt-q"] = actions.file_sel_to_qf,
                    }
                }
            })
        end,
        keys = {
            { "<c-p>", "<CMD>FzfLua files<CR>" },
            { "<c-f>", "<CMD>FzfLua grep_project<CR>" },
            { "<leader>b", "<CMD>FzfLua buffers<CR>" },
        },
    }
}
