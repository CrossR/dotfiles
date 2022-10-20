-- Neovim LSP config

local cmp = require'cmp'
local lspkind = require('lspkind')

-------------------------------------------------------------------------------
-- Setup LSP First....
-------------------------------------------------------------------------------

local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

    vim.keymap.set('n', '<leader>dS', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', '<leader>wS', vim.lsp.buf.workspace_symbol, bufopts)
end

-------------------------------------------------------------------------------
-- Then cmp
-------------------------------------------------------------------------------

cmp.setup({

    enabled = function()
        return vim.bo.filetype ~= "tex" or
            vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
    end,
    history = true,

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },

    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },

    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'latex-symbols' },
    }, {
        { name = 'buffer' },
        })
})

cmp.setup.cmdline('/', {
    sources = {
    { name = 'buffer' }
    }
})

-------------------------------------------------------------------------------
-- Finally, combine
-------------------------------------------------------------------------------

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'pyright', 'clangd' }

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
    }
end
