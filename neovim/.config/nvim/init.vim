" Most config is stored in an individual file in the `config` folder.

" Clear all
augroup initvim
    autocmd!
augroup END

" Function to load multiple config files.
function! LoadPluginConfig() abort

    let l:plugin_folder = g:config_folder . 'plugins'
    let s:plugins = split(globpath(l:plugin_folder, '*.vim'), '\n')

    for plugin in s:plugins
        try
            exe 'source ' . plugin
        catch
            echohl WarningMsg
            echom 'Error: ----->' . v:exception
            echom 'Could not load ' . plugin
            echohl none
        endtry
    endfor

endfunction

" Function to source a vim file.
function! Source(file) abort
    try
        exe 'source ' . g:config_folder . a:file
    catch
        echohl WarningMsg
        echom 'Error: ----->' . v:exception
        echom 'Could not load ' . a:file
        echohl none
    endtry
endfunction

" Source all the other config.

if has('win32')
    if has('nvim')
        let g:config_folder = fnamemodify(expand($MYVIMRC), ':p:h') . '/config/'
    else
        let g:vim_folder = expand('~/.vim/')
        let g:config_folder = fnamemodify(expand($MYVIMRC), ':p:h') . '/.vim/config/'
    endif
else
    if has('nvim')
        let g:vim_folder = expand('~/.config/nvim/')
        let g:config_folder = expand('~/.config/nvim/config/')
    else
        let g:vim_folder = expand('~/.vim/')
        let g:config_folder = expand('~/.vim/config/')
    endif
endif

call Source('general.vim')
call Source('mappings.vim')
call Source('plugins.vim')
call Source('filetypes.vim')
call LoadPluginConfig()
