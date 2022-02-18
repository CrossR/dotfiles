" Fugitive

function! Gstatus_Wrapper() abort

    if ! exists(':Gstatus')
        return
    endif

    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        if winwidth(0) >= 160
            exec 'vertical topleft Git'
        else
            exec 'botright Git'
        endif
    endif
endfunction

" Bindings
nnoremap <silent> <leader>gs :call Gstatus_Wrapper()<CR>

