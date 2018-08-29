" Black

autocmd BufWritePost *.py execute ':Black'

if exists('g:venv_folder')
    let g:black_virtualenv = g:venv_folder
endif

