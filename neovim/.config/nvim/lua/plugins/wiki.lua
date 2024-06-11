-- Wiki Config
return {
    {
        "lervag/wiki.vim",
        dependencies = { "dhruvasagar/vim-table-mode", "mhinz/neovim-remote" },
        cmd = { "WikiIndex" },
        config = function()
            local git_default_dir = os.getenv("GIT_DEFAULT_DIR")
            if git_default_dir == nil then
                git_default_dir = "~/git"
            end
            if vim.fn.isdirectory(git_default_dir) == 0 then
                print("The directory " .. git_default_dir .. " does not exist.")
                return 1
            end

            vim.g.wiki_root = git_default_dir .. "/wiki/docs"
            vim.g.wiki_filetypes = { "md" }
            vim.g.wiki_link_extension = ".md"

            vim.g.wiki_link_target_type = "md"
            vim.g.wiki_link_target_map = "WikiLinkFunction"

            -- Define a vim function to open a wiki link
            vim.fn.WikiLinkFunction = function(target)
                return string.lower(target):gsub("\\s+", "_")
            end

            -- Set textwidth to 88 for markdown files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                command = "setlocal textwidth=88",
            })

            vim.g.wiki_export = {
                args = {
                    "-V geometry:margin=0.5in",
                    "-H " .. git_default_dir .. "/wiki/pandoc/listings-setup.tex",
                    "--listings",
                },
                from_format = "markdown",
                ext = "pdf",
                view = true,
                output = "pdfs/",
            }
        end,
    },
}
