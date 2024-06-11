-- Fugitive Config
return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git<CR>")
        end,
        cmd = "Git",
    },
}
