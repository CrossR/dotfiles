" fzf

if exists('g:gui_oni')
    finish
endif

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <c-p> :ProjectFiles<cr>
