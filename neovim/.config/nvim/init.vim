start                   " insert mode by default
set number              " display line numbers
set ignorecase          " set search to case insensitive
set smartcase           " except when the search has capital letters

call plug#begin('~/.local/share/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
call plug#end()


" color scheme theme
syntax enable
set background=dark
let g:solarized_termtrans = 1   " fixes ugly grey bg
colorscheme solarized

