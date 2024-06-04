-- Global Filetype Config
-- Skeleton for new filetypes
-- Given a filetype, find the template and add it to the buffer
local function add_template(ft)
    local template = string.format("%s/skeleton/skeleton.%s", vim.g.vim_folder, ft)

    if vim.fn.filereadable(template) == 1 then
        vim.cmd("0r " .. template)
    end
end

-- Auto commands to add templates for given filetypes
vim.cmd([[
augroup Skeleton_Loading
    autocmd!
    autocmd BufNewFile *.sh call v:lua.add_template('sh')
augroup END
]])

-- For the C-style languages, set the commentstring to // rather than /* */
vim.cmd([[
augroup CStyleComment
    autocmd!
    autocmd FileType c,cpp,cuda setlocal commentstring=//\ %s
augroup END
]])
