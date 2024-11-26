-- Vimtex Config
return {
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
        end,
        keys = {
            { "<F8>", ":VimtexCountWords<CR>" },
            { "<F9>", ":VimtexCompile<CR>" },
            { "<F10>", ":VimtexTocToggle<CR>" },
            { "<F11>", ":VimtexClean<CR>" },
        },
    },
}
