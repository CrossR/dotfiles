" supports \usepackage{array}
"  Author: Karl Yngve Leråg <karl.yngve@gmail.com>
"  Date:   May 16, 2017
"  Version: 1a
" ---------------------------------------------------------------------
let b:loaded_array = "v1a"
let s:keepcpo      = &cpo
set cpo&vim

" ---------------------------------------------------------------------
if get(g:, 'tex_fast', 'M') =~# 'M'
  syntax clear texMathZoneX
  if has('conceal') && &enc ==# 'utf-8' && get(g:, 'tex_conceal', 'd') =~# 'd'
    syntax region texMathZoneX matchgroup=Delimiter start="\([<>]{\)\@<!\$" skip="\%(\\\\\)*\\\$" matchgroup=Delimiter end="\$" end="%stopzone\>" concealends contains=@texMathZoneGroup
  else
    syntax region texMathZoneX matchgroup=Delimiter start="\([<>]{\)\@<!\$" skip="\%(\\\\\)*\\\$" matchgroup=Delimiter end="\$" end="%stopzone\>" contains=@texMathZoneGroup
  endif
endif

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ft=vim ts=4 fdm=marker
