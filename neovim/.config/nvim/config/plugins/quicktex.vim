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
    \'v<':     '\vec{<+++>}<++>',
    \'b<':     '\bra{<+++>}<++>',
    \'k<':     '\ket{<+++>}<++>',
    \'bk<':    '\braket{<+++>|<++>}<++>',
    \'nui':    '\nu_i ',
    \'nul':    '\nu_l ',
    \'nu':     '\nu_\mu ',
    \'nue':    '\nu_e ',
    \'nutau':  '\nu_\tau ',
    \'anui':   '\bar{\nu}_i ',
    \'anul':   '\bar{\nu}_l ',
    \'anu':    '\bar{\nu}_\mu ',
    \'anue':   '\bar{\nu}_e ',
    \'anutau': '\bar{\nu}_\tau ',
    \'l+':     'l^+ ',
    \'l-':     'l^- ',
    \'e+':     'e^+ ',
    \'e-':     'e^- ',
    \'mu+':    '\mu^+ ',
    \'mu-':    '\mu^- ',
    \'t+':     '\tau^+ ',
    \'t-':     '\tau^- ',
    \'pi+':    '\pi^+ ',
    \'pi-':    '\pi^- ',
    \'pi0':    '\pi^0 ',
    \'w+-':    'W^\pm ',
    \'w+':     'W^+ ',
    \'w-':     'W^- ',
    \'z0':     'Z^0 ',
    \'decay':  '\Gamma ',
    \'sin':    '\sin(<+++>)<++>',
    \'cos':    '\cos(<+++>)<++>',
    \'sin2':   '\sin^2(<+++>)<++>',
    \'cos2':   '\cos^2(<+++>)<++>',
    \'dm2':    '\Delta m^2 ',
    \'t12':    '\theta_{12}',
    \'t13':    '\theta_{13}',
    \'t23':    '\theta_{23}',
    \'dcp':    '\delta_{\mathrm{CP}} ',
    \'gev':    '\text{ GeV}',
    \'gevc':   '\text{ GeV} / \text{c}',
    \'gevc2':  '\text{ GeV} / \text{c}^2'
    \}

let g:quicktex_tex = {
    \' ':    "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
    \'\beg': '\begin{<+++>}<++>',
    \'\end': '\end{<+++>}<++>',
    \'\eq':  "\\begin{equation}\<CR>" .
           \ "<+++>\<CR>" .
           \ "\\label{eq:<++>}\<CR>" .
           \ "\\end{equation}",
    \'\eqa': "\\begin{align}\<CR>" .
           \ "<+++>\<CR>" .
           \ "\\label{eq:<++>}\<CR>" .
           \ "\\end{align}",
    \'\fig': "\\begin{figure}[hbtp]\<CR>" .
           \ "\\centering\<CR>" .
           \ "\\includegraphics[width=<+++>\\textwidth]{<++>}\<CR>" .
           \ "\\caption[<++>]{\<CR>" .
           \ "<++>\<CR>" .
           \ "}%\<CR>" .
           \ "\\label{fig:<++>}\<CR>" .
           \ "\\end{figure}",
    \'\daS': "\\DeclareAcronym{<+++>}{short = <++>, long = <++>}",
    \'\daL': "\\DeclareAcronym{<+++>}{\<CR>" .
           \ "short = <++>,\<CR>" .
           \ "long = <++>\<CR>" .
           \ "}",
    \ '\s': '\acs{<+++>} <++>',  '\S': '\Acs{<+++>} <++>',
    \ '\f': '\acf{<+++>} <++>',  '\F': '\Acf{<+++>} <++>',
    \}

let s:current_path = expand('<sfile>:p')
command! TexLoadMath silent execute ":source " . s:current_path

