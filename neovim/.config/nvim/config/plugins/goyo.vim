" goyo

let g:goyo_linenr = 0
let g:goyo_width = 90

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

nnoremap <leader>go <cmd>call Toggle_goyo()<CR>

