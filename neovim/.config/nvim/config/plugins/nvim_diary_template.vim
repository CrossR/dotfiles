" nvim_diary_template

if !has('python3') || !has('nvim')
    finish
endif

let g:nvim_diary_template#notes_path = $GIT_DEFAULT_DIR . "/wiki/docs/"
let g:nvim_diary_template#config_path = $GIT_DEFAULT_DIR . "/wiki/config/"
let g:nvim_diary_template#auto_generate_diary_index = 1
let g:nvim_diary_template#google_cal_name = 'NVim Notes'
let g:nvim_diary_template#repo_name = 'CrossR/wiki'
let g:nvim_diary_template#user_name = 'CrossR'
let g:nvim_diary_template#calendar_filter_list = ['Holidays in United Kingdom']
let g:nvim_diary_template#sort_order = {
            \ "issue.complete": 10000,
            \ "backlog": 5000,
            \ "onhold": 2500,
            \ "blocked": 1000,
            \ "default": 100,
            \ "inprogress": 0,
            \ }

