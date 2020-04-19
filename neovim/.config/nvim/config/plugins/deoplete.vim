" Deoplete

if !has('python3') || !has('nvim')
    finish
endif

let g:deoplete#auto_complete_delay = 0

augroup DeopleteInsertEnable
    autocmd!
    autocmd InsertEnter * call deoplete#enable()
augroup END

if !exists('g:deoplete#sources')
  let g:deoplete#sources = {}
endif

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file']
let g:deoplete#sources.markdown = ['gh_label', 'gh_repo', 'google_cals', 'file', 'omni']
let g:deoplete#sources.python = []
let g:deoplete#sources.typescript = []
let g:deoplete#sources.javascript = []

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

