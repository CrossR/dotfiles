" lightline

if exists('g:gui_oni')
    finish
endif

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ 'tabline': {'left': [['buffers']], 'right': [['close']]},
            \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
            \ 'component_type': {'buffers': 'tabsel'},
            \ }
