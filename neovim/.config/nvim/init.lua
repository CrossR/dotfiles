require("core.general")
require("core.mappings")
require("core.filetypes")

-- Setup global variables for other config files
-- vim_folder is the path to the neovim config directory
-- config_folder is then the config directory in the neovim config directory
vim.g.vim_folder = vim.fn.stdpath("config")
vim.g.config_folder = vim.g.vim_folder .. "/lua/config"

-- Load the rest of the config files
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
    ui = {
        border = "rounded",
    },
})
