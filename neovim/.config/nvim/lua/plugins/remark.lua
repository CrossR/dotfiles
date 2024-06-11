-- Remark config
return {
    {
        "CrossR/vim-remarkjs",
        ft = "markdown",
        config = function()
            vim.g.remarkjs_global = vim.fn.stdpath("config")
                .. "/assets/remarkjs_template.html"
            vim.g.remarkjs_local = vim.fn.stdpath("config")
                .. "/assets/local_remarkjs_template.html"

            vim.g.remarkjs_template = vim.g.remarkjs_global

            -- Vim function to switch between global and local templates
            vim.fn.Remark_Local = function()
                -- Check the cache is in %:p:h
                if
                    vim.fn.filereadable(vim.fn.expand("%:p:h") .. "/remark_cache") == 0
                then
                    print(
                        "Cache missing, should be in "
                            .. vim.fn.expand("%:p:h")
                            .. "/remark_cache"
                    )
                    return 1
                end

                vim.g.remarkjs_template = vim.g.remarkjs_local
                vim.cmd("RemarkPreview")
                vim.g.remarkjs_template = vim.g.remarkjs_global
            end
        end,
        keys = {
            { "<leader>rr", ":RemarkPreview<CR>" },
            { "<leader>rl", ":call Remark_Local()<CR>" },
        },
    },
}
