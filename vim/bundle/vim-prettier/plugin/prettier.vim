" vim-prettier: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"
" Script Info  {{{
"==========================================================================================================
" Name Of File: prettier.vim
"  Description: A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.
"   Maintainer: Mitermayer Reis <mitermayer.reis at gmail.com>
"      Version: 0.0.15
"        Usage: Use :help vim-prettier-usage, or visit https://github.com/prettier/vim-prettier
"
"==========================================================================================================
" }}}

if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

" => Plugin config
" autoformating enabled by default upon saving
let g:prettier#autoformat = get(g:, 'prettier#autoformat', 1)

" calling :Prettier by default runs synchronous
let g:prettier#exec_cmd_async = get(g:, 'prettier#exec_cmd_async', 0)

" when having formatting errors will open the quickfix by default
let g:prettier#quickfix_enabled = get(g:, 'prettier#quickfix_enabled', 1)

" => Prettier CLI config
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = get(g:, 'prettier#config#print_width', 80)

" number of spaces per indentation level
let g:prettier#config#tab_width = get(g:,'prettier#config#tab_width', 2)

" use tabs over spaces
let g:prettier#config#use_tabs = get(g:,'prettier#config#use_tabs', 'false')

" print semicolons
let g:prettier#config#semi = get(g:,'prettier#config#semi', 'true')

" single quotes over double quotes
let g:prettier#config#single_quote = get(g:,'prettier#config#single_quote', 'true')

" print spaces between brackets
let g:prettier#config#bracket_spacing = get(g:,'prettier#config#bracket_spacing', 'false')

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = get(g:,'prettier#config#jsx_bracket_same_line', 'true')

" none|es5|all
let g:prettier#config#trailing_comma = get(g:,'prettier#config#trailing_comma', 'all')

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = get(g:,'prettier#config#parser', 'flow')

" synchronous by default
command! -nargs=? -range=% Prettier call prettier#Prettier(g:prettier#exec_cmd_async, <line1>, <line2>)

" prettier async
command! -nargs=? -range=% PrettierAsync call prettier#Prettier(1, <line1>, <line2>)

" map command
if !hasmapto('<Plug>(Prettier)') && maparg('<Leader>p', 'n') ==# ''
  nmap <unique> <Leader>p <Plug>(Prettier)
endif
nnoremap <silent> <Plug>(Prettier) :Prettier<CR>
nnoremap <silent> <Plug>(PrettierAsync) :PrettierAsync<CR>
