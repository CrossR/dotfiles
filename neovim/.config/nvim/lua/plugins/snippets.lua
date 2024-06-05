-- LuaSnip config
return {
    "L3MON4D3/LuaSnip",
    config = function()
        require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })
        require("luasnip.loaders.from_lua").lazy_load({
            paths = vim.g.vim_folder .. "snippets",
        })
    end,
    keys = {
        {
            "<c-w>",
            function()
                ls.expand_or_jumpable()
            end,
            { silent = true },
        },
        {
            "<c-e>",
            function()
                ls.jump(1)
            end,
            { silent = true },
        },
        {
            "<c-q>",
            function()
                ls.jump(-1)
            end,
            { silent = true },
        },
    },
}
