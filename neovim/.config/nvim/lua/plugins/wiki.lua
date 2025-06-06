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

        end,
    },
    {
        "dhruvasagar/vim-table-mode",
        cmd = { "TableModeToggle" },
        config = function()
            vim.keymap.set("n", "<leader>wt", ":TableModeToggle<CR>", {
                silent = true,
            })
        end,
    },
}
