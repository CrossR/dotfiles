" lightline

if exists('g:gui_oni')
    finish
endif

let g:lightline = {
            \ 'separator': {'left': '', 'right': ''},
            \ 'subseparator': {'left': '', 'right': ''},
            \ 'active': {
            \   'left': [['mode', 'paste'],
            \            ['gitbranch'],
            \            ['readonly', 'filename', 'modified']],
            \   'right': [['lineinfo'],
            \             ['percent'],
            \             ['fileformat', 'fileencoding', 'filetype'],
            \             ['code-note']],
            \ },
            \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
            \ 'component_type': {'buffers': 'tabsel'},
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }
