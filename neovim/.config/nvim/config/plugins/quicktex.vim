" quicktex

let g:quicktex_math = {
    \' ':      "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'frac':   '\frac{<+++>}{<++>} <++>',
    \'x10':    '\times 10^{<+++>}<++>',
    \'sum':    '\sum_{<+++>}<++>',
    \'delta':  '\Delta <+++>',
    \'to':     '\to ',
    \'pa2b':   'P(<+++> \to <++>)<++>',
    \'\ee':    '\end{equation}',
    \'\a':     '\begin{aligned}',
    \'\ea':    '\end{aligned}',
    \'->':     '\rightarrow ',
    \'<-':     '\leftarrow ',
    \'~t':     '\text{<+++>}<++>',
    \'v<':     '\bm{<+++>}<++>',
    \'nul':    '\nu_l',
    \'nu':     '\nu_\mu',
    \'nue':    '\nu_e',
    \'nutau':  '\nu_\tau',
    \'anul':   '\bar{\nu}_l',
    \'anu':    '\bar{\nu}_\mu',
    \'anue':   '\bar{\nu}_e',
    \'anutau': '\bar{\nu}_\tau',
    \'l+':     'l^+',
    \'l-':     'l^-',
    \'e+':     'e^+',
    \'e-':     'e^-',
    \'mu+':    '\mu^+',
    \'mu-':    '\mu^-',
    \'t+':     '\tau^+',
    \'t-':     '\tau^-',
    \'pi+':    '\pi^+',
    \'pi-':    '\pi^-',
    \'pi0':    '\pi^0',
    \'w+-':    'W^\pm',
    \'w+':     'W^+',
    \'w-':     'W^-',
    \'z0':     'Z^0',
    \'decay':  '\Gamma',
    \'sin':    '\sin(<+++>)<++>',
    \'cos':    '\cos(<+++>)<++>',
    \'sin2':   '\sin^2(<+++>)<++>',
    \'cos2':   '\cos^2(<+++>)<++>',
    \'dm2':    '\Delta m^2',
    \'t12':    '\theta_{12}',
    \'t13':    '\theta_{13}',
    \'t23':    '\theta_{23}',
    \'dcp':    '\delta_{CP}',
    \'GeV':    '\text{ GeV}',
    \'GeVc':   '\text{ GeV} / c^2'
    \}

let g:quicktex_tex = {
    \' ':    "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'\beg': '\begin{<+++>}<++>',
    \'\end': '\end{<+++>}<++>',
    \'\eq':  "\\begin{equation}\<CR>" .
           \ "<+++>\<CR>" .
           \ "\\label{<++>}\<CR>" .
           \ "\\end{equation}",
    \'\fig': "\\begin{figure}[tph]\<CR>" .
           \ "\\centering\<CR>" .
           \ "\\includegraphics[width=<+++>\\textwidth]{<++>}\<CR>" .
           \ "\\caption{<++>}%\<CR>" .
           \ "\\label{<++>}\<CR>" .
           \ "\\end{figure}"
    \}

let s:current_path = expand('<sfile>:p')
command! TexLoadMath silent execute ":source " . s:current_path

