" LSP / CMP / Snippets

if !has('nvim')
    finish
endif

" LuaSnip
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
imap <silent><expr> <C-e> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'

inoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(1)<Cr>
inoremap <silent> <C-j> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(-1)<Cr>

" Telescope
nnoremap <silent><expr> <c-p> (len(system('git rev-parse')) ? ':Telescope find_files' : ':Telescope git_files') . "\<CR>"
nnoremap <c-f> :Telescope live_grep<CR>
nnoremap <silent> <c-w> :Projects<CR>
nnoremap <silent> <leader>b :Telescope buffers<CR>

" Load snippets lua file
lua require('lsp_config')
lua require('cmp_config')
lua require('snippets')
lua require('tele_config')
