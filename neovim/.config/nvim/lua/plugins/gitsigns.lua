-- Git Signs Config
return {
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                signs = {},
            })
        end,
    },
}
