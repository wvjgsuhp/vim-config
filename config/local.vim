let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

set clipboard+=unnamedplus     " Yank without explicit registration

" Statusline theme
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

set number                     " Show current line number
set relativenumber             " Show relative line numbers

tnoremap <Esc> <C-\><C-n>|     " terminal -> normal mode

