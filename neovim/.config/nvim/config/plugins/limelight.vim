" limelight

if exists('g:gui_oni')
    finish
endif

" Auto toggle with Goyo.
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:limelight_conceal_ctermfg = 'gray'
