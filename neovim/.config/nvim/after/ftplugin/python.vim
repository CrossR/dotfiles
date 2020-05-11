" Python Config

" Run Python files on F9
nnoremap <silent><buffer> <F9> :exec '!python' shellescape(@%,1)<CR>

let g:python_highlight_all = 1
let g:python_slow_sync = 0

