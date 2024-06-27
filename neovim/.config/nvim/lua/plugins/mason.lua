-- Mason Bridge Config
return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                    border = "rounded",
                },
            })
        end,
    },
    {
        "frostplexx/mason-bridge.nvim",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-bridge").setup()

            require("conform").setup({
                formatters_by_ft = require("mason-bridge").get_formatters(),
            })
        end,
    },
}
