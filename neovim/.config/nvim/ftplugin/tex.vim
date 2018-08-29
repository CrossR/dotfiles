" Latex Config

" Run Count on F8, Compile on F9 and show Contents buffer on F10
" Also set spell checking and wrapping of text.

augroup TexConfig
    autocmd!
    autocmd FileType tex nnoremap <buffer> <F8> <cmd>VimtexCountWords<CR>
    autocmd FileType tex nnoremap <buffer> <F9> <cmd>VimtexCompile<CR>
    autocmd FileType tex nnoremap <buffer> <F10> <cmd>VimtexTocToggle<CR>
    autocmd FileType tex setlocal spell spelllang=en_gb " Spellchecking for .tex only
    autocmd FileType tex setlocal textwidth=80          " Wrap at 80 cols in .tex files.
    autocmd FileType tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
augroup END

