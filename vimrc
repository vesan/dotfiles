" An example for a vimrc file.

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

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

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

colorscheme railscasts
" Other nice ones: ir_black, inkpot

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

" nmap <C-A>  0
" nmap <C-B>  h
" nmap <C-D>  x
" nmap <C-E>  $
" nmap <C-F>  l
" nmap <ESC>b b
" nmap <ESC>f w

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Split mappings
map <C-H> <C-W>h<C-W><BAR>
map <C-L> <C-W>l<C-W><BAR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby set foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
" autocmd BufNewFile,BufRead *_spec.rb compiler rspec

let mapleader = ","

nmap :W<cr> :w<cr>
nmap :Q<cr> :q<cr>

" NERDTree
nmap <leader>d :NERDTreeToggle<cr>
nmap <leader>r :NERDTreeFind<cr>

" Emulate TextMate indenting style
nmap <a-Tab> >>
nmap <a-S-Tab> <<
vmap <a-Tab> >gv
vmap <a-S-Tab> <gv
" and Command-Enter functionality
inoremap <D-CR> <C-O>o

" Set SnipMate author
let g:snips_author = "Vesa Vänskä"
let g:snippets_dir = "~/.vim/snippets/"

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
map <leader>e :e <C-R>=expand("%:p:h") ."/"<CR>

" Get off the insert mode without Esc
nnoremap <C-space> i
imap <C-space> <Esc>
vmap <C-space> <Esc>

" Ruby
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

  " Rails keycombos
  imap <C-l> <Space>=><Space>

  " Rspec, needed for MakeGreen plugin
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" Prolog
  autocmd BufNewFile,BufRead ~/code/prolog/*.pl set filetype=prolog

" SASS
  autocmd BufNewFile,BufRead *.scss set filetype=css
