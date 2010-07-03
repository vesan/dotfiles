set guifont=DejaVu\ Sans\ Mono:h14  " Font family and font size.
set antialias                       " MacVim: smooth fonts.
set encoding=utf-8                  " Use UTF-8 everywhere.
set guioptions-=T                   " Hide toolbar.
set lines=62 columns=120           " Window dimensions.

" set guioptions-=r                 " Don't show right scrollbar

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen
end

