" Deoplete

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

" <TAB>: completion.
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <CR>: close popup and save indent.
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

if !exists('g:deoplete#sources')
  let g:deoplete#sources = {}
endif

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer']
let g:deoplete#sources.vimwiki = ['gh_label', 'gh_repo', 'file', 'vw_tag', 'omni']

" Disable for certain file types in Oni.

if !exists('g:gui_oni')
    augroup DisableDeoplete
        autocmd!
        autocmd FileType typescript let b:deoplete_disable_auto_complete = 1
        autocmd FileType javascript let b:deoplete_disable_auto_complete = 1
        autocmd FileType python let b:deoplete_disable_auto_complete = 1
    augroup END
endif

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Enable in VimWiki for tags.
let g:deoplete#omni#input_patterns.vimwiki = [':']

