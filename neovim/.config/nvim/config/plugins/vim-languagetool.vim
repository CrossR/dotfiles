" vim-language tool
" Requires languagetool to be installed.

let g:languagetool_jar="/usr/local/Cellar/languagetool/4.6/libexec/languagetool-commandline.jar"
let g:languagetool_lang = "en-GB"

"Enable all categories
let g:languagetool_enable_categories = 'PUNCTUATION,TYPOGRAPHY,CASING,COLLOCATIONS,CONFUSED_WORDS,CREATIVE_WRITING,GRAMMAR,MISC,MISUSED_TERMS_EU_PUBLICATIONS,NONSTANDARD_PHRASES,PLAIN_ENGLISH,TYPOS,REDUNDANCY,SEMANTICS,TEXT_ANALYSIS,STYLE,GENDER_NEUTRALITY'

"Enable all special rules that cannot be enabled via category
let g:languagetool_enable_rules = 'AND_ALSO,ARE_ABLE_TO,ARTICLE_MISSING,AS_FAR_AS_X_IS_CONCERNED,BEST_EVER,BLEND_TOGETHER,BRIEF_MOMENT,CAN_NOT,CANT_HELP_BUT,COMMA_WHICH,EG_NO_COMMA,ELLIPSIS,EXACT_SAME,HONEST_TRUTH,HOPEFULLY,IE_NO_COMMA,IN_ORDER_TO,I_VE_A,NEGATE_MEANING,PASSIVE_VOICE,PLAN_ENGLISH,REASON_WHY,SENT_START_NUM,SERIAL_COMMA_OFF,SERIAL_COMMA_ON,SMARTPHONE,THREE_NN,TIRED_INTENSIFIERS,ULESLESS_THAT,WIKIPEDIA,WORLD_AROUND_IT'

" Disable a bunch that get in the way of latex
" Underscores, Currency, white space, Dashes, Brackets => Used a bunch in math mode
" Spelling mistakes => Dealt with via the Vim dictionary
" Quotes => Shouldn't use smart quotes in Latex
let g:languagetool_disable_rules = 'WORD_CONTAINS_UNDERSCORE,MORFOLOGIK_RULE_EN_GB,CURRENCY,DASH_RULE,EN_QUOTES,WHITESPACE_RULE,EN_UNPAIRED_BRACKETS'
