" VimTex

let g:tex_flavor = 'latex'
let g:tex_conceal = ""
let g:vimtex_latexmk_progname = 'nvr'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=0',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Get Oni to use SumatraPDF as the VimTeX viewer

if exists('g:gui_oni')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

