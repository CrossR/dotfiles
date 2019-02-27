" vim-remarkjs

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let g:remarkjs_template = expand('<sfile>:p:h') . '/assets/remarkjs_template.html'

" Bindings
nnoremap <silent> <leader>rr :RemarkPreview<CR>
