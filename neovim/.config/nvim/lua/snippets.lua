-- LuaSnip config

local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Is the current environment math mode?
local function is_math(...)
    return vim.fn["vimtex#syntax#in_mathzone"]
end

local function tex_math_snip(trigger, expansion)
    return s(
        {trig = trigger, hidden = true},
        expansion,
        {condition = is_math}
    )
end

ls.add_snippets(nil, {
    tex = {
        tex_math_snip("frac",   {t("\\frac{"), i(1), t("}{"), i(2), t("}")}),
        tex_math_snip("x10",    {t("\\times 10^{"), i(1), t("}")}),
        tex_math_snip("sum",    {t("\\sum_{"), i(1), t("}")}),
        tex_math_snip("delta",  {t("\\Delta "), i(1)}),
        tex_math_snip("to",     {t("\\to ")}),
        tex_math_snip("pa2b",   {t("(P("), i(1), t(" \\to "), i(2), t(")")}),
        tex_math_snip("\\ee",   {t("\\end{equation}")}),
        tex_math_snip("\\a",    {t("\\begin{aligned}")}),
        tex_math_snip("\\ea",   {t("\\end{aligned}")}),
        tex_math_snip("->",     {t("\\rightarrow ")}),
        tex_math_snip("<-",     {t("\\leftarrow ")}),
        tex_math_snip("~t",     {t("\\text{"), i(1), t("}")}),
        tex_math_snip("v<",     {t("\\vec{"), i(1), t("}")}),
        tex_math_snip("b<",     {t("\\bra{"), i(1), t("}")}),
        tex_math_snip("k<",     {t("\\ket{"), i(1), t("}")}),
        tex_math_snip("bk<",    {t("\\braket{"), i(1), t("|"), i(2), t("}")}),
        tex_math_snip("nui",    {t("\\nu_i ")}),
        tex_math_snip("nul",    {t("\\nu_l ")}),
        tex_math_snip("nue",    {t("\\nu_e ")}),
        tex_math_snip("nu",     {t("\\nu_\\mu ")}),
        tex_math_snip("nutau",  {t("\\nu_\\tau ")}),
        tex_math_snip("anui",   {t("\\bar{\\nu}_i ")}),
        tex_math_snip("anul",   {t("\\bar{\\nu}_l ")}),
        tex_math_snip("anu",    {t("\\bar{\\nu}_\\mu ")}),
        tex_math_snip("anue",   {t("\\bar{\\nu}_e ")}),
        tex_math_snip("anutau", {t("\\bar{\\nu}_\\tau ")}),
        tex_math_snip("l+",     {t("l^+ ")}),
        tex_math_snip("l-",     {t("l^- ")}),
        tex_math_snip("e+",     {t("e^+ ")}),
        tex_math_snip("e-",     {t("e^- ")}),
        tex_math_snip("mu+",    {t("\\mu^+ ")}),
        tex_math_snip("mu-",    {t("\\mu^- ")}),
        tex_math_snip("t+",     {t("\\tau^+ ")}),
        tex_math_snip("t-",     {t("\\tau^- ")}),
        tex_math_snip("pi+",    {t("\\pi^+ ")}),
        tex_math_snip("pi-",    {t("\\pi^- ")}),
        tex_math_snip("pi0",    {t("\\pi^0 ")}),
        tex_math_snip("w+-",    {t("W^\\pm ")}),
        tex_math_snip("w+",     {t("W^+ ")}),
        tex_math_snip("w-",     {t("W^- ")}),
        tex_math_snip("z0",     {t("Z^0 ")}),
        tex_math_snip("decay",  {t("\\Gamma ")}),
        tex_math_snip("sin2",   {t("\\sin&^2("), i(1), t(")")}),
        tex_math_snip("cos2",   {t("\\cos&^2("), i(1), t(")")}),
        tex_math_snip("sin",    {t("\\sin("), i(1), t(")")}),
        tex_math_snip("cos",    {t("\\cos("), i(1), t(")")}),
        tex_math_snip("dm2",    {t("\\Delta m^2 ")}),
        tex_math_snip("t12",    {t("\\theta_{12}")}),
        tex_math_snip("t13",    {t("\\theta_{13}")}),
        tex_math_snip("t23",    {t("\\theta_{23}")}),
        tex_math_snip("dcp",    {t("\\delta_{\\mathrm{CP}} ")}),
        tex_math_snip("gev",    {t("\\text{ GeV}")}),
        tex_math_snip("gevc",   {t("\\text{ GeV} / \\text{c}")}),
        tex_math_snip("gevc2",  {t("\\{t(text{ GeV} / \\text{c}^2")}),

        ls.parser.parse_snippet({trig = "\\beg", name = "Environment"},
            "\\begin{$1}\n    $2\n\\end{$1}"
        ),
        s({trig = "\\eq", name = "Equation"},  {
            t({"\\begin{equation}",
            "    "}), i(1), t({"",
            "    \\label{eq:"}), i(2), t({"}",
            "\\end{equation}"})
        }),
        s({trig = "\\eqa", name = "Aligned Equation"},  {
            t({"\\begin{align}",
            "    "}), i(1), t({"",
            "    \\label{eq:"}), i(2), t({"}",
            "\\end{align}"})
        }),
        s({trig = "\\fig", name = "Figure"},  {
            t({
            "\\begin{figure}[hbtp]",
            "    \\centering",
            "    \\includegraphics[width="}), i(1), t("\\textwidth]{"), i(2), t({"}",
            "    \\caption["}), i(3), t({"]{",
            "        "}), i(4), t({"",
            "    }%",
            "    \\label{fig:"}), i(5), t({"}",
            "\\end{figure}"})
        }),
        ls.parser.parse_snippet({trig =  "\\s", hidden = true}, "\\acs{$1} $2"),
        ls.parser.parse_snippet({trig =  "\\S", hidden = true}, "\\Acs{$1} $2"),
        ls.parser.parse_snippet({trig =  "\\f", hidden = true}, "\\acf{$1} $2"),
        ls.parser.parse_snippet({trig = "\\F", hidden = true}, "\\Acf{$1} $2"),
        ls.parser.parse_snippet({trig = "\\daS", name = "Define Abbrev (Short)"},
            "\\DeclareAcronym{$1}{short = $2, long = $3}"
        ),
        s({trig = "\\daL", name = "Define Abbrev (Long)"},  {
            t("\\DeclareAcronym{"), i(1), t({"}{",
            "    short = "}), i(2), t({",",
            "    long = "}), i(3), t({"",
            "}"})
        })
    },
})

