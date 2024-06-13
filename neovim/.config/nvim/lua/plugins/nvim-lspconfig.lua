-- Neovim LSP Configuration
return {
    {
        "neovim/nvim-lspconfig",
        enabled = function()
            -- Don't enable for GPVMs that lack a loaded GCC module
            local gcc_module = os.getenv("GCC_VERSION")
            local hostname = vim.loop.os_gethostname()
            if string.find(hostname, "gpvm") and gcc_module == nil then
                return false
            end

            return true
        end,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "onsails/lspkind-nvim",
        },
        config = function()
            local lsp = require("lspconfig")
            local lspkind = require("lspkind")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local servers = { "pyright", "clangd" }

            for _, lsp in ipairs(servers) do
                require("lspconfig")[lsp].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    flags = lsp_flags,
                })
            end

            local opts = {
                noremap = true,
                silent = true,
            }

            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local bufnr = args.buf

                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(
                        bufnr,
                        "omnifunc",
                        "v:lua.vim.lsp.omnifunc"
                    )

                    -- Mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local bufopts = {
                        noremap = true,
                        silent = true,
                        buffer = bufnr,
                    }

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

                    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set(
                        "n",
                        "<leader>td",
                        vim.lsp.buf.type_definition,
                        bufopts
                    )
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)

                    vim.keymap.set(
                        "n",
                        "<leader>wa",
                        vim.lsp.buf.add_workspace_folder,
                        bufopts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        bufopts
                    )
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, bufopts)

                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

                    vim.keymap.set(
                        "n",
                        "<leader>dS",
                        vim.lsp.buf.document_symbol,
                        bufopts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>wS",
                        vim.lsp.buf.workspace_symbol,
                        bufopts
                    )
                end,
            })
        end,
    },
}
