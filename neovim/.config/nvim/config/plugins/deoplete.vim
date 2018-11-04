" Deoplete

if !has('python3') || !has('nvim')
    finish
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

if !exists('g:deoplete#sources')
  let g:deoplete#sources = {}
endif

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer']
let g:deoplete#sources.vimwiki = ['gh_label', 'gh_repo', 'file', 'vw_tag', 'omni']
let g:deoplete#sources.python = []
let g:deoplete#sources.typescript = []
let g:deoplete#sources.javascript = []

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Enable in VimWiki for tags.
let g:deoplete#omni#input_patterns.vimwiki = [':']

