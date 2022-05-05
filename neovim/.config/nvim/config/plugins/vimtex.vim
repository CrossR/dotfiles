" VimTex

let g:tex_flavor = 'latex'
let g:tex_conceal = ""
let g:vimtex_syntax_enabled = 1

let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
                \   '-shell-escape',
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
            \}

" Filter these warnings
"   - First is due to a LaTeX update and translations.sty not being updated yet
let g:vimtex_quickfix_ignore_filters = [
            \ ".*file\/after\/translations-basic-dictionary-english\.trsl.*",
            \ "Package svg Warning: Since the encountered filedate of file*",
            \]

" Get Oni to use SumatraPDF as the VimTeX viewer

if exists('g:gui_oni')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

if has('macunix')
    let g:vimtex_view_method = 'skim'
endif

