-- Mappings
-- Remap comma as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Clipboard Mappings
vim.keymap.set("v", "<leader>y", '"+y', {
    noremap = true,
    silent = true,
})
vim.keymap.set("v", "<leader>Y", '"+yg_', {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<leader>p", '"+p', {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<leader>P", '"+P', {
    noremap = true,
    silent = true,
})

-- Move between splits more easily
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", {
    noremap = true,
    silent = true,
})

-- Map j/k to gj/gk in normal mode
vim.keymap.set("n", "j", "gj", {
    noremap = true,
    silent = true,
})
vim.keymap.set("n", "k", "gk", {
    noremap = true,
    silent = true,
})

-- Make . repeat work in visual mode
vim.keymap.set("v", ".", ":norm.<CR>", {
    noremap = true,
    silent = true,
})

-- Leave terminal mode with ESC
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
    noremap = true,
    silent = true,
})

-- Clumsy typing corrections to quit / save
-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Wqa wqa
]])

-- Use Ctrl-L in insert mode to fix the previous typo
vim.keymap.set("i", "<C-l>", "<C-G>u<Esc>[s1z=`]a<C-G>u", {
    noremap = true,
    silent = true,
})
