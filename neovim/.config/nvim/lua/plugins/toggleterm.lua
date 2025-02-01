return {
    "akinsho/nvim-toggleterm.lua",
    event = "VeryLazy",
    version = "*",
    opts = {
        start_in_insert = true,
        insert_mappings = false,
        shade_terminals = false,
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return math.floor(vim.o.columns * 0.4)
            end
        end,
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Basic command, just set ,, to toggle the terminal
        vim.keymap.set("n", "<leader>,", "<cmd>lua require('toggleterm').toggle()<CR>", {
            desc = "toggleterm: Toggle terminal",
        })

        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
        })
        vim.keymap.set("n", "<leader>lg", function()
            lazygit:toggle()
        end, {
            desc = "toggleterm: Toggle lazygit",
        })

        local _slidev_start = function()
            local slidev = Terminal:new({
                cmd = "npm run --prefix ~/git/wiki dev " .. vim.fn.expand("%:p"),
                display_name = "slidev Server",
                on_exit = function(t, j, e, e)
                    print("Slidev server stopped")
                end,
                direction = "float",
            })
            slidev:spawn()
            print("slidev: Development server started...")
        end

        vim.keymap.set("n", "<leader>sv", function()
            _slidev_start()
        end, {
            desc = "toggleterm: Start slidev",
        })
    end,
}
