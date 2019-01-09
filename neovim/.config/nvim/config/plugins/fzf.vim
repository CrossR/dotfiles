" fzf

if exists('g:gui_oni')
    finish
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
