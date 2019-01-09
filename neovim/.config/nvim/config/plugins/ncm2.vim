" ncm2

if exists('g:gui_oni') || !has('nvim')
    finish
endif

autocmd BufEnter python,c,cpp call ncm2#enable_for_buffer()
autocmd FileType c,cpp nnoremap <buffer> gd <cmd><c-u>call ncm2_pyclang#goto_declaration()<cr>

set completeopt=noinsert,menuone,noselect

let g:ncm2_pyclang#library_path = '~/Tools/clang/lib'
let g:ncm2_pyclang#args_file_path = ['.clang_complete']

