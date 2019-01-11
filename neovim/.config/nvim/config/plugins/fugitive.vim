" Fugitive

function! Gstatus_Wrapper() abort
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        if winwidth(0) >= 160
            exec 'vert 80Gstatus'
        else
            exec 'bo 20Gstatus'
        endif
    endif
endfunction

" Bindings
nnoremap <leader>gs <cmd>call Gstatus_Wrapper()<CR>

