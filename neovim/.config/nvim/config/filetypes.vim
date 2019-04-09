" Filetype config

augroup CommentStrings
    autocmd!

    autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
augroup END

function! Add_Template(lang) abort
    let l:template_path = g:vim_folder . "skeleton/skeleton." . a:lang
    silent exec 0 . 'read ' . l:template_path
endfunction

augroup Skeleton_Loading
    autocmd!

    autocmd BufNewFile  *.sh call Add_Template('sh')
augroup END
