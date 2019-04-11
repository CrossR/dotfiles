" fzf

if exists('g:gui_oni')
    finish
endif

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

nnoremap <c-p> <cmd>GFiles<cr>

command! -bang -nargs=* GLines
            \ call fzf#vim#grep(
            \ 'rg --vimgrep --smart-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>),
            \ 1,
            \ {'options': '--delimiter : --nth 4..'},
            \ <bang>0
            \ )

nnoremap <c-f> :GLines<space>

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

nnoremap <c-w> <cmd>Projects<CR>
nnoremap <leader>b <cmd>Buffers<CR>
