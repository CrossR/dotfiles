"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Screenshot Plugin
"
" Prompt the user for a file name and then launch a screen shot tool.
" That is `screencapture` on mac, and `input` on Linux.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:last_image_taken = ""

" Build up the screenshot command and run it.
"
" If a second argument is given, we treat it as a number
" of seconds to pause by, before the screenshot.
"
" For now, lets always insert the screenshot link too, since I always do that.
function! Take_Screenshot(...) abort

    let file_name = a:1
    let cwd = expand('%:p:h')
    let screenshot_command = ''

    if has("unix")
        " Use the built-in command on Mac, and ImageMagick on Linux.
        if (system('uname') =~ "darwin")
            let screenshot_command = 'screencapture -s ' . cwd . '/' . file_name . '.png'
        else
            let screenshot_command = 'import ' . cwd . '/' . file_name . '.png'
        endif
    endif

    let final_command = screenshot_command

    " If we were given a time, lets use that to sleep for that long.
    " If its not a number, str2nr will return 0.
    if a:0 > 1
        let sleep_time = str2nr(a:2)
        let sleep_command = 'sleep ' . sleep_time . 's'
        let final_command = sleep_command . ' && ' . screenshot_command
    endif

    let g:last_image_taken = './' . file_name . '.png'

    " Actually run the screenshot command now.
    call system(final_command)

    call Insert_Screenshot()
endfunction

" Generate the markdown for the previous screenshot.
function! Insert_Screenshot() abort
    if g:last_image_taken != ""
        let cur_pos = getpos(".")
        let file_name = g:last_image_taken
        let desc = substitute(g:last_image_taken, '_', ' ', "g")
        let markdown = '![' . desc . '](' . file_name .')'
        call setline('.', markdown)
        call setpos('.', [0, cur_pos[1], 2, 0])
    endif
endfunction

" If we can find an image folder, lets auto complete that alongside any
" folders inside it.
"
" If we can't... Then just don't give anything and let the user do it.
function! ImageDirComplete(arg, cli, cur_pos)
    let cwd = expand('%:p:h')
    if isdirectory(cwd . '/images')
        let image_dir_contents = glob('images/**', 0, 1)
        call filter(image_dir_contents, 'isdirectory(v:val)')

        return ['images/'] + image_dir_contents
    endif

    return []
endfunction

" Link the two functions up to commands, with the auto-complete function for
" picking the save location.
command! -nargs=+ -complete=customlist,ImageDirComplete Screenshot call Take_Screenshot(<f-args>)
command! -nargs=0 InsertScreenshot call Insert_Screenshot()
