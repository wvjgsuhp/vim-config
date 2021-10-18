let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

" Statusline theme
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

let mapleader = ' '

set clipboard+=unnamedplus     " Yank without explicit registration
set showcmd
set number                     " Show current line number
set relativenumber             " Show relative line numbers

" Mapping
" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>

" Go to tab by number
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<cr>

" Jump to the beginning/end of a line
noremap <Leader>h ^
noremap <Leader>l $

" Discard all changes
noremap <Leader>q :e!<cr>
