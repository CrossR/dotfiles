" fzf

if exists('g:gui_oni')
    finish
endif

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <c-p> :ProjectFiles<cr>

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg --vimgrep --smart-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>),
            \ 1,
            \ {'options': '--delimiter : --nth 4..'},
            \ <bang>0
            \ )

nnoremap <c-f> :Rg<space>
