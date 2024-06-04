return {{
    "hrsh7th/nvim-cmp",
    enabled = function()
        -- Don't enable for GPVMs that lack a loaded GCC module
        local gcc_module = os.getenv("GCC_VERSION")
        local hostname = vim.loop.os_gethostname()
        if string.find(hostname, "gpvm") and gcc_module == nil then
            return false
        end

        return true
    end,
    event = "InsertEnter",
    opts = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            window = {
                completion = {
                    border = "rounded",
                    scrollbar = false
                },
                documentation = {
                    border = "rounded",
                    scrollbar = false
                }
            },
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<CR>"] = cmp.mapping.confirm()
            },
            history = true,
            formatting = {
                format = lspkind.cmp_format({
                    with_text = false,
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        return vim_item
                    end
                })
            },

            sources = cmp.config.sources({{
                name = 'nvim_lsp'
            }, {
                name = 'path'
            }, {
                name = 'luasnip'
            }, {
                name = 'latex-symbols'
            }}, {{
                name = 'buffer'
            }})
        }
    end
}}
