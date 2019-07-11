" quicktex

let g:quicktex_markdown = {
    \' ':      "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'eq':     '= ',
    \'frac':   '\frac{<+++>}{<++>} <++>',
    \'x10':    '\times 10^{<+++>}',

    \'nu':     '\nu_\mu ',
    \'nue':    '\nu_e ',
    \'nutau':  '\nu_\ta ',

    \'anu':    '\bar{\nu}_\mu ',
    \'anue':   '\bar{\nu}_e ',
    \'anutau': '\bar{\nu}_\tau ',

    \'pi+':    '\pi^+ ',
    \'pi-':    '\pi^- ',
    \'mu+':    '\mu^+ ',
    \'mu-':    '\mu^- ',
    \'e+':    '\e^+ ',
    \'e-':    '\e^- ',


    \'sin':    '\sin(<+++>) <++>',
    \'cos':    '\cos(<+++>) <++>',
    \'sin2':   '\sin^2(<+++>) <++>',
    \'cos2':   '\cos^2(<+++>) <++>',

    \'to':     '\to ',
    \'pa2b':   'P(<+++> \to <++>) <++>',

    \'dm2':    '\Delta m^2',

    \'t12':    '\theta_{12}',
    \'t13':    '\theta_{13}',
    \'t23':    '\theta_{23}',
    \}
