" Mappings

" Remaps
let mapleader = ","  " Set leader to ,

nmap j gj
nmap k gk

noremap <Leader>y "+y
noremap <Leader>p "+p

vnoremap <silent> . :normal .<CR>

" Esc to leave terminal
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Setup moving between splits.
" Not set in Oni since Oni needs a more complete solution to work
" with the various nvim instance in its UI, so this is set in the
" Oni config.tsx.
if !exists('g:gui_oni')
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
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

" Use Ctrl-L in insert mode to fix the previous typo
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u

nnoremap <leader>, <cmd>Nuake<CR>

" When the <Enter> key is pressed while the pop-up menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
