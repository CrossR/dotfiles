" Python Config

" Run Python files on F9
augroup PythonConfig
    autocmd!
    autocmd FileType python nnoremap <buffer> <F9> <cmd>exec '!python' shellescape(@%,1)<CR>
augroup END

