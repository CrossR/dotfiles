" goyo

if exists('g:gui_oni')
    let g:goyo_width = 90
    let g:goyo_linenr = 1
else
    let g:goyo_width = 90
    let g:goyo_linenr = 1
endif

function! Toggle_goyo()
  if has('termguicolors') && !&termguicolors
      set termguicolors
      :Goyo
  elseif has('termguicolors') && &termguicolors
      :Goyo
      set notermguicolors
  endif
endfunction

nnoremap <leader>go <cmd>call Toggle_goyo()<CR>

