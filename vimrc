" An example for a vimrc file.

let mapleader = ","

" Don't load PeepOpen
let g:peepopen_loaded = 1

" Command-T config
let g:CommandTMatchWindowAtTop = 1

map <silent> <leader>t :CommandTFlush<cr>\|:CommandT<cr>

" To get rid of complaining makegreen
if !hasmapto('<Plug>MakeGreen')
  map <unique> <silent> <Leader>ö <Plug>MakeGreen
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Rock the simple shell instead of ZSH
set shell=/bin/sh

silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

runtime macros/matchit.vim        " Load the matchit plugin.

set nobackup	                    " do not keep a backup file, use versions instead
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set noswapfile                    " ... or don't keep swap files at all

set history=50	                  " keep 50 lines of command line history
set showcmd		                    " display incomplete commands
set showmode		                  " display the mode you're in.

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

" set winwidth=84

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

set wildignore+=*.o,*.png,*.PNG,*.JPG,*.jpg,*.jpeg,,*.gif,*.pdf,*.jar,*.scssc,coverage/**,tmp/**

" Shortcut to rapidly toggle `set list`
map <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

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
else

  set autoindent		" always set autoindenting on

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
cnoremap <C-D>      <Del>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
" cnoremap <ESC>b     <S-Left>
" cnoremap <ESC>f     <S-Right>
" cnoremap <ESC><C-H> <C-W>

" Normal mode - emacs style movements [960425]

nmap <C-A>  0
nmap <C-B>  h
nmap <C-D>  x
nmap <C-E>  $
nmap <C-F>  l
nmap <ESC>b b
nmap <ESC>f w

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
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<cr>
  vmap <Leader>a= :Tabularize /=<cr>
  nmap <Leader>a: :Tabularize /:\zs<cr>
  vmap <Leader>a: :Tabularize /:\zs<cr>
endif

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

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>
nmap <silent> ,7 :nohlsearch<cr>

" Sudo
cmap w!! w !sudo tee % >/dev/null

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

" Prolog
  autocmd BufNewFile,BufRead ~/code/prolog/*.pl set filetype=prolog

" ActionScript
  autocmd BufNewFile,BufRead *.as set filetype=actionscript

" CSS
  autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS

" Crazy
" Building Lauri's environment :-)
nmap <leader>å :vsp<cr>:vsp<cr>:sp<cr><C-w>l:sp<cr><C-w>l:sp<cr>

" Ack
" map <leader>s :Ack <c-r><c-w><cr>
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

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1           " Rainbow parentheses'!

" Load local configs
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

