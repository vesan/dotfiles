set gfn=Menlo\ Regular:h14
set antialias                       " MacVim: smooth fonts.
set encoding=utf-8                  " Use UTF-8 everywhere.
set guioptions-=T                   " Hide toolbar.
set lines=62 columns=100           " Window dimensions.

" set guioptions-=r                 " Don't show right scrollbar

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-r> :Rake<cr>

  cd ~/Dropbox/Notes
end

" Load local configs
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

let g:vimwiki_url_maxsave=0
