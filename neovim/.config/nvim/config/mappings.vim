" Mappings

" Remaps
let mapleader = ","  " Set leader to ,

nmap j gj
nmap k gk

noremap <Leader>y "+y
noremap <Leader>p "+p

vnoremap . <cmd>normal .<CR>

" Esc to leave terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Fix clumsy typing to quit
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wqa wqa

nnoremap <leader>, <cmd>call Term_toggle()<CR>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

