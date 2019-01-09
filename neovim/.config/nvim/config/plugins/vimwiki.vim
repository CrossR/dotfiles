" VimWiki

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let default_wiki = {}

let default_wiki.path = $GIT_DEFAULT_DIR . "/wiki/docs"
let default_wiki.syntax = 'markdown'
let default_wiki.ext = ".md"
let default_wiki.auto_tags = 1
let default_wiki.list_margin = 0

let g:vimwiki_list = [default_wiki]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = 'custom'

let g:wiki_scratch_open = 0
let g:wiki_scratch_buf_nr = 0

" Set all the headers to different colours.
" Uses highlight groups that should be bound in most colour schemes.
highlight link VimwikiHeader1 Statement
highlight link VimwikiHeader2 Identifier
highlight link VimwikiHeader3 Type
highlight link VimwikiHeader4 Constant
highlight link VimwikiHeader5 Include
highlight link VimwikiHeader6 Title

function! Wiki_Scratch() abort

    if g:wiki_scratch_open == 1
        if g:wiki_scratch_buf_nr == bufnr("")
            setlocal bufhidden=hide
            hide
            let g:wiki_scratch_open = 0
        endif
    elseif g:wiki_scratch_open == 0

        botright 15new
        let g:wiki_scratch_open = 1

        try
            exec "buffer " . g:wiki_scratch_buf_nr
        catch
            exec 'edit ' . g:vimwiki_list[0].path . "/misc/TemporaryNotes.md"
            let g:wiki_scratch_buf_nr = bufnr("")
        endtry
    endif

endfunction

nnoremap <leader>sw <Plug>VimwikiUISelect
nnoremap <leader>ws <cmd>call Wiki_Scratch()<CR>

augroup WikiConfig
    autocmd!
    autocmd FileType vimwiki nnoremap <buffer> <leader>wt :VimwikiTable<space>
    autocmd FileType vimwiki nnoremap <buffer> <leader>wc <cmd>VimwikiTOC<CR>

    autocmd FileType vimwiki nmap <F7> i<C-R>=strftime("%H:%M %p")<CR>
    autocmd FileType vimwiki imap <F7> <C-R>=strftime("%H:%M %p")<CR>

    autocmd FileType vimwiki nmap <F8> i<C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>
    autocmd FileType vimwiki imap <F8> <C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>

    autocmd FileType vimwiki setlocal spell spelllang=en_gb " Spellchecking for VimWiki only
    autocmd FileType vimwiki setlocal textwidth=88          " Wrap at 88 cols in VimWiki files.
augroup END

