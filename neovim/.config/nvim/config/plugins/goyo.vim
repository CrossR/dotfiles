" goyo

let g:goyo_linenr = 0
let g:goyo_width = 100
let g:goyo_height = 90

function! Toggle_goyo()
  if exists('g:gui_oni') && has('termguicolors') && !&termguicolors
      set termguicolors
      :Goyo
  elseif exists('g:gui_oni') && has('termguicolors') && &termguicolors
      :Goyo
      set notermguicolors
  else
    :Goyo
  endif
endfunction

function! s:goyo_enter()
  if exists('$TMUX')
    silent !tmux set status off
  endif
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

augroup GoyoConfig
    autocmd!

    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

nnoremap <silent> <leader>go :call Toggle_goyo()<CR>

