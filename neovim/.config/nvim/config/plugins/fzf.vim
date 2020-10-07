" fzf

if exists('g:gui_oni')
    finish
endif

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

command! -bang Projects
            \ call fzf#run(
            \ fzf#wrap(
            \ 'project_list',
            \ {
            \ 'source': 'ls -d *',
            \ 'dir': $GIT_DEFAULT_DIR,
            \ 'sink': 'lcd',
            \ 'down': 10,
            \ },
            \ <bang>0
            \ ))

command! -bang Sessions
            \ call fzf#run(
            \ fzf#wrap(
            \ 'session_list',
            \ {
            \ 'source': 'ls *.vim',
            \ 'dir': g:vim_folder . 'sessions',
            \ 'sink': 'Obsession',
            \ 'down': 10,
            \ },
            \ <bang>0
            \ ))

" Bind Ctrl-p to be the files search.
" Calls GFiles in a git repository, and files otherwise.
nnoremap <silent><expr> <c-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles') . "\<CR>"

nnoremap <c-f> :Rg<space>
nnoremap <silent> <c-w> :Projects<CR>
nnoremap <silent> <leader>b :Buffers<CR>
