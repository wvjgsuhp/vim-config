execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/vimrc'

let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

"yank
set clipboard+=unnamedplus

"statusline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

"terminal -> normal mode
tnoremap <Esc> <C-\><C-n>
