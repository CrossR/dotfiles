-- In Editor Auto-Completion

-- Only accept if there is words before the cursor...
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
        local luasnip = require("luasnip")

        return {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = "menu,menuone"
            },
            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Select
                }), {'i'}),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Select
                }), {'i'}),
                ['<C-n>'] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            fallback()
                        end
                    end
                }),
                ['<C-p>'] = cmp.mapping({
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                        end
                    end,
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            fallback()
                        end
                    end
                }),
                ['<C-o>'] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")
                    if copilot.is_visible() then
                        copilot.accept()
                    else
                        fallback()
                    end
                end),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
                -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                }),
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true
                        })
                    elseif require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {"i", "s"})
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
