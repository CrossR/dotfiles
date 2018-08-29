" Mappings

" Remaps
nmap j gj
nmap k gk
let mapleader = ","  " Set leader to ,
vnoremap . <cmd>norm.<CR>
command! RootSave <cmd>execute '<cmd>silent w !sudo tee % >/dev/null' | <cmd>edit
tnoremap <Esc> <C-\><C-n>
nnoremap <C-L> <cmd>nohlsearch<CR><C-L>

" Fix clumsy typing to quit
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wqa wqa

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal toggle setup
" Setup an array to store the relevant buf nums and last used term
" This is called by Oni since that stores an array of each terminal
" name and its associated command.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Term_toggle_setup(term_count) abort
    let g:term_buf = map(range(a:term_count), 0)
    let g:term_currently_open = map(range(a:term_count), 0)

    let g:last_term = ""
    let g:last_term_num = -1
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal open
" Open the releavant terminal, passed to nvim by Oni.
" If currently in the terminal, close it.
" Otherwise, attempt to swap to it and open it if that fails.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Term_open(term_num, term) abort
    let term_already_open = g:term_currently_open[a:term_num]

    if g:term_buf[a:term_num] == bufnr("")
        setlocal bufhidden=hide
        hide
        let g:term_currently_open[a:term_num] = 0
    elseif term_already_open == 0
        botright 15new
        let g:term_currently_open[a:term_num] = 1

        try
            exec "buffer ".g:term_buf[a:term_num]
        catch
            exec 'terminal ' . a:term
            let g:term_buf[a:term_num] = bufnr("")
        endtry
    endif

    let g:last_term = a:term
    let g:last_term_num = a:term_num
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal toggle
" Hide the currently active terminal,
" or show the last used one.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Term_toggle() abort
    " If the command wasn't called since we aren't
    " in Oni, only setup bash.
    if !exists('g:term_buf')
        call Term_toggle_setup(1)
        call Term_open(0, 'bash')
        return
    endif

    let currently_in_terminal = index(g:term_buf, bufnr(""))

    let other_term_index = index(g:term_currently_open, 1)
    let last_term_exists = g:last_term_num != -1 && g:last_term != ""

    if currently_in_terminal != -1
        setlocal bufhidden=hide
        hide
        let g:term_currently_open[currently_in_terminal] = 0
    elseif last_term_exists && other_term_index == -1
        call Term_open(g:last_term_num, g:last_term)
    endif
endfunction

nnoremap <leader>, :call Term_toggle()<CR>

