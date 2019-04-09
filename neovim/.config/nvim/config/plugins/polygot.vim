" vim-polygot

let g:polyglot_disabled = ['latex', 'cpp']

augroup CommentStrings
    autocmd!

    autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
augroup END

