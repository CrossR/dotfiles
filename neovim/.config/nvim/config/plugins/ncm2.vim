" ncm2

if exists('g:gui_oni') || !has('nvim')
    finish
endif

autocmd BufEnter python call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect
