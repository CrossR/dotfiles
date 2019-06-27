" vim-remarkjs

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let g:remarkjs_global = expand('<sfile>:p:h') . '/assets/remarkjs_template.html'
let g:remarkjs_local = expand('<sfile>:p:h') . '/assets/local_remarkjs_template.html'

let g:remarkjs_template = g:remarkjs_global

function! Remark_Local() abort

    " Check the cache is there.
    if !isdirectory(expand('%:p:h') . '/remark_cache')
        echohl WarningMsg
        echo "Cache is not setup! Run the relevant script first..."
        echo "Cache folder should be in"
        echo expand('%:p:h') . '/remark_cache'
        return
    endif

    " Temporarily swap to the local template.
    let g:remarkjs_template = g:remarkjs_local

    exec 'RemarkPreview'

    " Revert template back.
    let g:remarkjs_template = g:remarkjs_global
endfunction

" Bindings
nnoremap <silent> <leader>rr :RemarkPreview<CR>
nnoremap <silent> <leader>rl :call Remark_Local()<CR>
