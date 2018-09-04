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
nnoremap <leader>ws :call Wiki_Scratch()<CR>

