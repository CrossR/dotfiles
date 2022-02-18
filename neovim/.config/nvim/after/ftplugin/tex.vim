" Latex Config

" Run Count on F8, Compile on F9 and show Contents buffer on F10
" Also set spell checking and wrapping of text.
nnoremap <buffer> <F8> :VimtexCountWords<CR>
nnoremap <buffer> <F9> :VimtexCompile<CR>
nnoremap <buffer> <F10> :VimtexTocToggle<CR>
nnoremap <buffer> <F11> :VimtexClean<CR>
setlocal spell spelllang=en_gb " Spellchecking for .tex only
setlocal textwidth=80          " Wrap at 80 cols in .tex files.


lua << EOF
  local nvim_lsp = require('lspconfig')

  nvim_lsp.ltex.language = "en-GB"
  nvim_lsp.ltex.disabledRules = {
      "OXFORD_SPELLING_NOUNS",
  }
EOF
