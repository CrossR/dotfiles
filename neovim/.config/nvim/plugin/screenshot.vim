"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Screenshot loader
"
" Prompt the user for a file name and the launch a screen shot tool.
" That is `screencapture` on mac, and `___` on Linux.
"
" Going to try and include some logic to find the most appropriate folder for
" the given file.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Take_Screenshot(file_name) abort
    let cwd = expand('%:p:h')
    let screenshot_command = 'screencapture -s ' . cwd . '/' . a:file_name . '.png'
    call system(screenshot_command)
endfunction

" If we can find an image dir, lets auto complete that alongside any folders
" directly inside it.
"
" If we can't... then just don't give anything and let the user do it.
function! ImageDirComplete(arg, cli, cur_pos)
    let cwd = expand('%:p:h')
    if isdirectory(cwd . '/images')
        let image_dir_contents = glob('images/**', 0, 1)
        call filter(image_dir_contents, 'isdirectory(v:val)')

        return ['images/'] + image_dir_contents
    endif

    return []
endfunction

command! -nargs=1 -complete=customlist,ImageDirComplete Screenshot call Take_Screenshot(<q-args>)
