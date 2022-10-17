let $VIM_PATH = expand('<sfile>:p:h:h')
let g:python3_host_prog = $VIM_PATH . '/env/bin/python3'

set clipboard+=unnamedplus     " Yank without explicit registration

" Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_section_z = airline#section#create([g:airline_symbols.colnr, '%v'])
let g:airline_detect_spell = 0
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

let mapleader = ' '

set clipboard+=unnamedplus     " Yank without explicit registration
set showcmd
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set tabstop=2 shiftwidth=2 expandtab

" Markdown TOC
let g:vmt_list_item_char = '-'

" fzf x ag
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--path-to-ignore ~/.ignore --color-path="0;33"', <bang>0)
" command! -bang -nargs=* Ag
"   \ call fzf#vim#grep(
"   \   'ag --path-to-ignore ~/.ignore --column --numbers --smart-case --noheading --color ' . shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" set rtp+=/usr/local/opt/fzf

" Formatting
let g:neoformat_sql_sqlformat = {
	    \ 'exe': 'sqlformat',
	    \ 'args': ['--keywords=upper']
	    \ }

let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': ['--max-line-length=80', '--experimental'],
            \ }

augroup formatting
  autocmd!
	autocmd BufWritePre *.js Neoformat
	autocmd BufWritePre *.jsx Neoformat
	autocmd BufWritePre *.ts Neoformat
	autocmd BufWritePre *.tsx Neoformat
	autocmd BufWritePre *.json Neoformat
	autocmd BufWritePre *.py Neoformat
	autocmd BufWritePre *.md Neoformat
	autocmd BufWritePre *.sql Neoformat
	autocmd BufWritePre *.rs Neoformat
augroup END

" Save sessions
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" Mapping
" Go from terminal to normal mode
tnoremap <Esc> <C-\><C-n>

" Paste
nnoremap <Leader>piw viwpyiw
nnoremap <Leader>pa ggVGp

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
noremap <Leader>0 <cmd>tablast<cr>

" Jump to the beginning/end of a line
noremap <Leader>h ^
noremap <Leader>l $

" Open terminal
noremap <Leader>z <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><bar><cmd>terminal<cr>13<c-w>_i
noremap <Leader>zl <cmd>vsplit<cr><bar><cmd>terminal<cr>i

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^><cr>

" Fix incorrect highlight
noremap <Leader>ffs <cmd>colorscheme github<cr>

" Yank
nnoremap <Leader>yfn <cmd>let @+=expand("%")<CR><cmd>echo 'Yanked filename'<CR>
nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR><cmd>echo 'Yanked relative path'<CR>
nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR><cmd>echo 'Yanked absolute path'<CR>
nnoremap <Leader>yaa ggyG''

" Delete
nnoremap <Leader>dif j<cmd>foldclose<cr>kd1j

" Delete current file
nnoremap <Leader>rm <cmd>call delete(expand('%'))<bar>bd!<cr>

" Close current buffer
nnoremap <Leader>bd <cmd>b#<bar>bd#<CR>

" Git
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Search
nnoremap <Leader>agp :Ag <C-r>0<cr>
nnoremap <Leader>agiw yiw:Ag <C-r>0<cr>

" Find
nnoremap <Leader>fp /<C-r>0<cr>
nnoremap <Leader>fiw yiw/<C-r>0<cr>
