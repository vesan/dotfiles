" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off " required for vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-abolish'
Bundle 'milesz/ack'
Bundle 'vim-scripts/actionscript.vim--Leider'
Bundle 'epmatsw/ag.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'vim-scripts/IndexedSearch'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'adimit/prolog.vim'
Bundle 'rafaelfranca/rtf_pygmentize'
Bundle 'vesan/scss-syntax.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/taglist.vim'
Bundle 'timcharper/textile.vim'
Bundle 'nelstrom/textobj-rubyblock'
Bundle 'kana/textobj-user'
Bundle 'tpope/vim-bundler'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-cucumber'
Bundle 'elixir-lang/vim-elixir'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/VimClojure'
Bundle 'gmarik/vundle'
Bundle 'derekwyatt/vim-scala'
Bundle 'bleything/vim-slidedown'
Bundle 'tpope/vim-surround'
Bundle 'tomtom/tcomment_vim'
Bundle 'skalnik/vim-vroom'

filetype plugin indent on

let mapleader = ","

" Don't load PeepOpen
let g:peepopen_loaded = 1

" ctrl-p config
let g:ctrlp_map = '<leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 20

" To get rid of complaining makegreen
if !hasmapto('<Plug>MakeGreen')
  map <unique> <silent> <Leader>ö <Plug>MakeGreen
endif

" Rock the simple shell instead of ZSH
set shell=/bin/sh

" silent! call pathogen#runtime_append_all_bundles()
" silent! call pathogen#helptags()

runtime macros/matchit.vim        " Load the matchit plugin.

set nobackup                      " do not keep a backup file, use versions instead
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set noswapfile                    " ... or don't keep swap files at all

set history=50                    " keep 50 lines of command line history
set showcmd                       " display incomplete commands
set showmode                      " display the mode you're in.

set backspace=indent,eol,start    " allow backspacing over everything in insert mode

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.
set cursorline                    " Highlight current line.

set incsearch                     " Highlight matches as you type.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set tabstop=2                     " Global tab width.
set softtabstop=2                 " And again, related.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs
set softtabstop=2

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set splitbelow

set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set nofoldenable " disable folding

set autoread " if file has been changed outside of vim, reload it

" set winwidth=84

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

set wildignore+=*.o,*.png,*.PNG,*.JPG,*.jpg,*.jpeg,*.JPEG,*.gif,*.pdf,*.jar,*.scssc,coverage/**,tmp/**

" Shortcut to rapidly toggle `set list`
map <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Vim 7.4 is really slow with Ruby files unless you set this.
set regexpengine=1

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Native clipboard integration
set clipboard=unnamed

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Reload vim config automatically after editing it
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost vimrc source $MYVIMRC

  " Highlight trailing whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd WinEnter * match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

set background=dark
colorscheme solarized
" Other nice ones: ir_black, inkpot, railscasts

" Customizing Vim
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" COMMAND LINE CUSTOMIZATIONS
" Basic emacs keybindings

cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <Down>
cnoremap <C-P>      <Up>
" cnoremap <ESC>b     <S-Left>
" cnoremap <ESC>f     <S-Right>
" cnoremap <ESC><C-H> <C-W>

" Normal mode - emacs style movements [960425]

nmap <C-A>  0
nmap <C-B>  h
nmap <C-E>  $
nmap <C-F>  l
nmap <ESC>b b
nmap <ESC>f w

imap <c-e> <c-o>$
imap <c-a> <c-o>^

" Split mappings
" map <C-H> <C-W>h<C-W><BAR>
" map <C-L> <C-W>l<C-W><BAR>
" map <C-J> <C-W>j<C-W>_
" map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h
map <C-L> <C-W>l
map <C-J> <C-W>j
map <C-K> <C-W>k

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby set foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
" autocmd BufNewFile,BufRead *_spec.rb compiler rspec

command! W w
command! Q q


" NERDTree
nmap <leader>d :NERDTreeToggle<cr>
nmap <leader>r :NERDTreeFind<cr>

" vim-vroom
let g:vroom_map_keys = 0
map <Leader>v :VroomRunTestFile<CR>
map <Leader>V :VroomRunNearestTest<CR>

" HTML
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Emulate TextMate indenting style
nmap <M-Tab> >>
nmap <M-S-Tab> <<
vmap <M-Tab> >gv
vmap <M-S-Tab> <gv
" and Command-Enter functionality
inoremap <D-CR> <C-O>o

" Set SnipMate author
let g:snips_author = "Vesa Vänskä"
let g:snippets_dir = "~/.vim/snippets/"

" Tabular
" TODO Fix the if, for some reason with it the code is not loaded
" if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<cr>
  vmap <Leader>a= :Tabularize /=<cr>
  nmap <Leader>a: :Tabularize /:\zs<cr>
  vmap <Leader>a: :Tabularize /:\zs<cr>
  nmap <Leader>a{ :Tabularize /{<cr>
  vmap <Leader>a{ :Tabularize /{<cr>
" endif

let Tlist_WinWidth = 30

" Faster way to get to previous file
nmap gb <C-^>     

" Shortcuts for per line moving
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g0
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g0

" Text bubbling (moving lines and visual selections)
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Autocomplete file edit path to current file path
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :e %%

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

function! OpenChangedFiles()
  only
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

nmap <leader><space> :call whitespace#strip_trailing()<CR>

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>
nmap <silent> ,7 :nohlsearch<cr>

" Sudo
cmap w!! w !sudo tee % >/dev/null

" Ruby
map <leader>c :!ruby -I"test" -I"spec" %<CR>

" Ruby
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd BufNewFile,BufRead *.ru set ft=ruby
  autocmd BufNewFile,BufRead *.rabl set ft=ruby

  " Rails keycombos
  imap <C-l> <Space>=><Space>

  " Rspec, needed for MakeGreen plugin
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec

  " Promote variable to RSpec let
  function! PromoteToLet()
    normal! dd
    " exec '?^\s*it\>'
    normal! P
    .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    normal ==
  endfunction
  command! PromoteToLet :call PromoteToLet()
  map <leader>p :PromoteToLet<cr>

  let g:rails_projections = {
          \ "app/uploaders/*_uploader.rb": {
          \   "command": "uploader",
          \   "template":
          \     "class %SUploader < CarrierWave::Uploader::Base\nend",
          \   "test": [
          \     "spec/models/%s_uploader_spec.rb",
          \     "test/unit/%s_uploader_test.rb"
          \   ],
          \   "keywords": "process version"
          \ },
          \ "features/support/*.rb": {"command": "support"},
          \ "features/support/env.rb": {"command": "support"}}
          \ "spec/factories/*_factory.rb": {
          \   "command": "factory",
          \   "affinity": "model",
          \   "related": "app/models/%s.rb",
          \   "template": "FactoryGirl.define do\n  factory :%s do\n  end\nend"
          \ },
          \ "app/presenters/*_presenter.rb": {
          \   "command": "presenter",
          \   "affinity": "model",
          \   "alternate": ["spec/presenters/%s_presenter_spec.rb", "test/presenters/%s_presenter_test.rb"],
          \   "related": "app/models/%s.rb",
          \   "template": "class %SPresenter\nend"
          \ },
          \ "app/authorizers/*_authorizer.rb": {
          \   "command": "authorizer",
          \   "affinity": "model",
          \   "alternate": ["spec/authorizers/%s_authorizer_spec.rb", "test/authorizers/%s_authorizer_test.rb"],
          \   "related": "app/models/%s.rb",
          \   "template": "class %SAuthorizer < ApplicationAuthorizer\nend"
          \ },
          \ "config/locales/*fi.yml": { "alternate": "%sen.yml" },
          \ "config/locales/*en.yml": { "alternate": "%sfi.yml" }


" Prolog
  autocmd BufNewFile,BufRead ~/code/prolog/*.pl set filetype=prolog

" ActionScript
  autocmd BufNewFile,BufRead *.as set filetype=actionscript

" CSS
  autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS

noremap <leader>å :set paste<CR>:put *<CR>:set nopaste<CR>

noremap + :cn<cr>
noremap - :cp<cr>

" Ack
" map <leader>s :Ack <c-r><c-w><cr>
let g:ackprg = 'ag --nogroup --nocolor --column'
map <leader>s :execute "Ack " . expand("<cword>") <cr>

" Search for selected text, forwards or backwards.
" From http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" find merge conflict markers
nnoremap <Leader>! /\v^[<=>]{7}( <Bar>$)/<Return>

" visually select the text that was last edited or pasted
nnoremap gV `[v`]

" visually select a search result
nnoremap g/ //e<Return>v??<Return>

" Preserve flags when repeating a substitution
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1           " Rainbow parentheses'!

" tmux

" http://snk.tuxfamily.org/log/vim-256color-bce.html
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
  set t_ut=
endif

" Load local configs
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

