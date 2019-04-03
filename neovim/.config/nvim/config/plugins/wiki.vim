" VimWiki

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let g:wiki_root = $GIT_DEFAULT_DIR . "/wiki/docs"
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'

let g:wiki_link_target_map = 'WikiLinkFunction'
let g:wiki_link_target_type = 'md'

function WikiLinkFunction(text) abort
    return substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction

let g:wiki_journal = {
            \ 'name': 'diary',
            \ 'frequency': 'daily',
            \ 'date_format': {
            \   'daily' : '%Y-%m-%d',
            \   'weekly' : '%Y_w%V',
            \   'monthly' : '%Y_m%m',
            \ },
            \}

" Markdown options
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

let g:wiki_scratch_open = 0
let g:wiki_scratch_buf_nr = 0

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
            exec 'edit ' . g:wiki_root . "/misc/TemporaryNotes.md"
            let g:wiki_scratch_buf_nr = bufnr("")
        endtry
    endif

endfunction

nnoremap <leader>ws <cmd>call Wiki_Scratch()<CR>

function! Set_Markdown_Highlights() abort
    " Set all the headers to different colours.
    " Uses highlight groups that should be bound in most colour schemes.
    highlight link htmlH1 Statement
    highlight link htmlH2 Identifier
    highlight link htmlH3 Type
    highlight link htmlH4 Constant
    highlight link htmlH5 Include
    highlight link htmlH6 Title
endfunction

augroup WikiConfig
    autocmd!

    autocmd ColorScheme * call Set_Markdown_Highlights()

    autocmd FileType markdown nnoremap <buffer> <leader>wt :TableModeToggle<CR>
    autocmd FileType markdown nnoremap <buffer> <leader>wc <cmd>WikiPageToc<CR>

    autocmd FileType markdown nmap <F7> i<C-R>=strftime("%H:%M %p")<CR>
    autocmd FileType markdown imap <F7> <C-R>=strftime("%H:%M %p")<CR>

    autocmd FileType markdown nmap <F8> i<C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>
    autocmd FileType markdown imap <F8> <C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>

    autocmd FileType markdown setlocal spell spelllang=en_gb " Spellchecking for VimWiki only
    autocmd FileType markdown setlocal textwidth=88          " Wrap at 88 cols in VimWiki files.
augroup END

