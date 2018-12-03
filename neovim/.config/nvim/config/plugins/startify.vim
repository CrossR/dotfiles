" Startify

if exists('g:gui_oni')
    finish
endif

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

if !has('win32')
    let g:startify_session_dir = '~/.config/nvim/sessions'
else
    let g:startify_session_dir = '~/AppData/Local/nvim/sessions'
endif

let git_folders = globpath($GIT_DEFAULT_DIR, '*', 0, 1)
let g:startify_bookmarks = filter(git_folders, 'isdirectory(v:val)')

let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 5

