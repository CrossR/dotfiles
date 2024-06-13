-- Neovim treesitter Config
return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = function()
            -- Don't enable for GPVMs that lack a loaded GCC module
            local gcc_module = os.getenv("GCC_VERSION")
            local hostname = vim.loop.os_gethostname()
            if string.find(hostname, "gpvm") and gcc_module == nil then
                return false
            end

            return true
        end,
        build = ":TSUpdate all",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",
        },
        config = function()
            opts = {
                sync_install = false,
                ignore_install = { "markdown", "markdown_inline" },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]o"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]O"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[o"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[O"] = "@class.outer",
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        include_surrounding_whitespace = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ao"] = "@class.outer",
                            ["io"] = "@class.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                },
            }

            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
