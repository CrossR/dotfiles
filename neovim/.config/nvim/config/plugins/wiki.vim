" VimWiki

if empty($GIT_DEFAULT_DIR)
    echoerr "$GIT_DEFAULT_DIR isn't set."
endif

let g:wiki_root = $GIT_DEFAULT_DIR . "/wiki/docs"
let g:code_notes#notes_root = g:wiki_root . "/code/"
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'

" Setup the type of links I want, and how they should look
let g:wiki_link_target_map = 'WikiLinkFunction'
let g:wiki_link_target_type = 'md'

" Convert "My Wiki Link" to "my_wiki_link"
function! WikiLinkFunction(text) abort
    return substitute(tolower(a:text), '\s', '_', 'g')
endfunction

let g:wiki_journal = {
            \ 'name': 'diary',
            \ 'frequency': 'daily',
            \ 'date_format': {
            \   'daily' : '%Y-%m-%d',
            \   'weekly' : '%Y_w%V',
            \   'monthly' : '%Y_m%m',
            \ },
            \ }

" Set the export configuration.
let g:wiki_export = {
            \ 'args' : '-V geometry:margin=0.5in -H ' . $GIT_DEFAULT_DIR . '/wiki/pandoc/listings-setup.tex --listings',
            \ 'from_format' : 'markdown',
            \ 'ext' : 'pdf',
            \ 'view' : v:true,
            \ 'output' : 'pdfs/'
            \ }

" Override some default bindings.
" Remove the Page-TOC bind, since I barely use it and prefer ,wt for enabling
" the writing of wiki tables.
let g:wiki_mappings_local = {
            \ '<plug>(wiki-page-toc)' : '<leader>wtoc',
            \}

" Markdown options
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_fenced_languages = [
            \ 'c++=cpp',
            \ 'viml=vim',
            \ 'bash=sh',
            \ 'ini=dosini',
            \ 'py=python',
            \ 'md=markdown']

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

nnoremap <silent> <leader>ws :call Wiki_Scratch()<CR>

augroup WikiConfig
    autocmd!

    autocmd FileType markdown nnoremap <silent><buffer> <leader>wt :TableModeToggle<CR>
    autocmd FileType markdown nnoremap <silent><buffer> <leader>wc :WikiPageToc<CR>

    autocmd FileType markdown nnoremap <silent><buffer> <leader>wv :silent WikiExport<CR>

    " Screenshot binds
    autocmd FileType markdown nnoremap <buffer> <leader>ss :Screenshot<SPACE>
    autocmd FileType markdown nnoremap <silent><buffer> <leader>s<leader>s :silent InsertScreenshot<CR>a

    autocmd FileType markdown nmap <F7> i<C-R>=strftime("%H:%M %p")<CR>
    autocmd FileType markdown imap <F7> <C-R>=strftime("%H:%M %p")<CR>

    autocmd FileType markdown nmap <F8> i<C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>
    autocmd FileType markdown imap <F8> <C-R>=strftime("%Y-%m-%d %H:%M %p")<CR>

    autocmd FileType markdown setlocal spell spelllang=en_gb " Spellchecking for Wiki only
    autocmd FileType markdown setlocal textwidth=88          " Wrap at 88 cols in Wiki files.
augroup END

