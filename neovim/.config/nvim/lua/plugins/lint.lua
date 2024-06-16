-- nvim-lint formatter Config
return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            python = { "ruff" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
