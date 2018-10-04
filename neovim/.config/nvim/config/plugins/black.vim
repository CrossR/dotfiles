" Black

if !has('python3')
    finish
endif

if exists('g:venv_folder')
    let g:black_virtualenv = g:venv_folder
endif

