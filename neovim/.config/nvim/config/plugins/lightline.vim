" lightline

if exists('g:gui_oni')
    finish
endif

function! CheckForNote() abort
  return code_notes#check_for_note() ? '📖' : ''
endfunction

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
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
            \   'gitbranch': 'fugitive#head',
            \   'code-note': 'CheckForNote'
            \ },
            \ }
