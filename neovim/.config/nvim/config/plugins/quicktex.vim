" quicktex

let g:quicktex_math = {
    \' ':      "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'eq':     '= ',
    \'frac':   '\frac{<+++>}{<++>} <++>',
    \'x10':    '\times 10^{<+++>}<++>',
    \'sum':    '\sum_{<+++>}<++>',
    \'delta':  '\Delta <+++>',
    \'nu':     '\nu_\mu',
    \'nue':    '\nu_e',
    \'nutau':  '\nu_\tau',
    \'anu':    '\bar{\nu}_\mu',
    \'anue':   '\bar{\nu}_e',
    \'anutau': '\bar{\nu}_\tau',
    \'pi+':    '\pi^+',
    \'pi-':    '\pi^-',
    \'mu+':    '\mu^+',
    \'mu-':    '\mu^-',
    \'e+':     '\e^+',
    \'e-':     '\e^-',
    \'sin':    '\sin(<+++>)<++>',
    \'cos':    '\cos(<+++>)<++>',
    \'sin2':   '\sin^2(<+++>)<++>',
    \'cos2':   '\cos^2(<+++>)<++>',
    \'to':     '\to ',
    \'pa2b':   'P(<+++> \to <++>)<++>',
    \'dm2':    '\Delta m^2',
    \'t12':    '\theta_{12}',
    \'t13':    '\theta_{13}',
    \'t23':    '\theta_{23}',
    \'dcp':    '\delta_{CP}',
    \'eeq':    '\end{equation}',
    \'->':     '\rightarrow ',
    \'<-':     '\leftarrow ',
    \}

let g:quicktex_tex = {
    \' ':      "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'beq':    '\begin{equation}',
    \'\b':    '\begin{<+++>}<++>',
    \'\e':    '\end{<+++>}<++>',
    \'\bfi':  '\begin{figure}[tph]',
    \'\efi':  '\end{figure}',
    \'\cen':  '\centering',
    \'\inc':  '\includegraphics[width=<+++>\textwidth]{<++>}<++>',
    \'\cap':  '\caption{<+++>}%<++>',
    \}
