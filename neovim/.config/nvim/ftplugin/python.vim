" Python Config

" Run Python files on F9
augroup PythonConfig
    autocmd!
    autocmd FileType python nnoremap <silent><buffer> <F9> :exec '!python' shellescape(@%,1)<CR>
augroup END

