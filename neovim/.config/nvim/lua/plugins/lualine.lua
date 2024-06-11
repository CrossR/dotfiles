-- LuaLine Config
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'AndreM222/copilot-lualine' },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox_dark",
                },
                sections =  {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff',
                        {
                            'diagnostics',
                            sources = { "nvim_diagnostic" },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
                        }
                    },
                    lualine_c = { 'filename' },
                    lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end,
    },
}
