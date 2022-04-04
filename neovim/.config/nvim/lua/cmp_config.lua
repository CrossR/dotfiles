-- nvim-cmp config

local cmp = require'cmp'
local lspkind = require('lspkind')

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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'pyright', 'clangd', 'tsserver' }

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        capabilities = capabilities
    }
end
