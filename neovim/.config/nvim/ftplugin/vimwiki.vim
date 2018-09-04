" VimWiki Config

augroup WikiConfig
    autocmd!
    autocmd FileType vimwiki nnoremap <buffer> <leader>wt :VimwikiTable<space>
    autocmd FileType vimwiki nnoremap <buffer> <leader>wc :VimwikiTOC<CR>

    autocmd FileType vimwiki nmap <F7> i<C-R>=strftime("%H:%M %p")<CR>
    autocmd FileType vimwiki imap <F7> <C-R>=strftime("%H:%M %p")<CR>

    autocmd FileType vimwiki nmap <F8> i<C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>
    autocmd FileType vimwiki imap <F8> <C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>

    autocmd FileType vimwiki setlocal spell spelllang=en_gb " Spellchecking for VimWiki only
    autocmd FileType vimwiki setlocal textwidth=88          " Wrap at 88 cols in VimWiki files.
augroup END

