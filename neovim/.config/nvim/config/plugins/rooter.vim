" vim-rooter

if exists('g:gui_oni')
    finish
endif

let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'
