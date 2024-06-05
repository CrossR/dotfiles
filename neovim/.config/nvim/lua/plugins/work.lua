-- General Work-related plugins
return {
    {
        "CrossR/vim-fhicl",
        ft = "fhicl",
        config = function()
            vim.g["vim_fhicl#search_command"] = "rg --type-add 'fcl:*.fcl' -tfcl"
            vim.g["vim_fhicl#search_current"] = 1
        end,
    },
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
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.tex_conceal = ""
            vim.g.vimtex_syntax_enabled = true

            if vim.fn.has("mac") == 1 then
                vim.g.vimtex_view_method = "skim"
            else
                vim.g.vimtex_view_method = "zathura"
            end

            vim.g.vimtex_compiler_latexmk = {
                build_dir = "",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    "-shell-escape",
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }

            vim.g.vimtex_quickfix_ignore_filters = {
                ".*file\\/after\\/translations-basic-dictionary-english\\.trsl.*",
                "Package svg Warning: Since the encountered filedate of file*",
                "You have requested package `acro2'",
            }

            -- Set textwidth to 80 for tex files
            vim.api.nvim_create_autocmd("FileType", { "tex", "setlocal textwidth=80" })
        end,
        keys = {
            { "<F8>", ":VimtexCountWords<CR>" },
            { "<F9>", ":VimtexCompile<CR>" },
            { "<F10>", ":VimtexTocToggle<CR>" },
            { "<F11>", ":VimtexClean<CR>" },
        },
    },
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
