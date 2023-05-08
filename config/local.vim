let $VIM_PATH = expand('<sfile>:p:h:h')
let g:python3_host_prog = $VIM_PATH . '/env/bin/python3'

set clipboard+=unnamedplus     " Yank without explicit registration
set cmdheight=0
set winbar+=%{%v:lua.require'nvim-navic'.get_location()%}
set showtabline=0
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set tabstop=2 shiftwidth=2 expandtab
set foldmethod=expr

" Status line
function! Recording()
  let l:recording_register = reg_recording()
  if l:recording_register == ""
    return ""
  else
    return 'recording @' .. l:recording_register .. " "
  endif
endfunction

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

call airline#parts#define_function('recording', 'Recording')
call airline#parts#define_accent('recording', 'red')
let s:section_c = [
  \ 'recording', '%<', 'file', ' ', 'readonly', 'coc_status', 'lsp_progress']
let g:airline_section_c = airline#section#create(s:section_c)

let g:airline_section_y = '%{strftime("%H:%M")}'
let g:airline_section_z = 'c:%v'
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

" Markdown TOC
let g:vmt_list_item_char = '-'

" bionic read
let g:flow_strength = 0.4

" fzf x ag
" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--path-to-ignore ~/.ignore --color-path="0;33"', <bang>0)
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
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

augroup buffer_execution
  autocmd FileType python map <buffer> <F9>
    \ <cmd>w<CR><cmd>exec '!python' shellescape(@%, 1)<CR>
  autocmd FileType python imap <buffer> <F9>
    \ <esc><cmd>w<CR><cmd>exec '!python' shellescape(@%, 1)<CR>
augroup END

augroup formatting
  autocmd!
  autocmd BufWritePre *.R Neoformat
  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.json Neoformat
  autocmd BufWritePre *.jsx Neoformat
  autocmd BufWritePre *.lua Neoformat
  autocmd BufWritePre *.py Neoformat
  autocmd BufWritePre *.rs Neoformat
  autocmd BufWritePre *.sql Neoformat
  autocmd BufWritePre *.ts Neoformat
  autocmd BufWritePre *.tsx Neoformat
  autocmd BufWritePre *.yaml Neoformat
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
tnoremap <Esc> <C-\><C-n>zz

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
nnoremap <Leader>l $
onoremap <Leader>l $
xnoremap <Leader>l $h

" Terminal
noremap <Leader>zz <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><cmd>terminal<cr>13<c-w>_i
nmap <Leader>zl <cmd>vsplit<cr> zz
command! ToggleTerminal call interface#toggleTerminal()
nnoremap <Leader>` <cmd>ToggleTerminal<cr>
nnoremap <Leader>z4 :term<cr>:vs<cr>:term<cr>:sp<cr>:term<cr>:wincmd h<cr>:sp<cr>:term<cr>

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous buffer
noremap <Leader>bb <c-^>

" Yank
if dein#tap('nvim-notify')
  nnoremap <Leader>yfn <cmd>let @+=expand("%:t")<CR>
    \ :lua vim.notify('Yanked filename: <c-r>+', 'info')<CR>
  nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR>
    \ :lua vim.notify('Yanked relative path: <c-r>+', 'info')<CR>
  nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR>
    \ :lua vim.notify('Yanked absolute path: <c-r>+', 'info')<CR>
else
  nnoremap <Leader>yfn <cmd>let @+=expand("%:t")<CR>
    \ <cmd>echo 'Yanked filename: <c-r>+'<CR>
  nnoremap <Leader>yrp <cmd>let @+=expand("%:~:.")<CR>
    \ <cmd>echo 'Yanked relative path: <c-r>+'<CR>
  nnoremap <Leader>yap <cmd>let @+=expand("%:p")<CR>
    \ <cmd>echo 'Yanked absolute path: <c-r>+'<CR>
endif

nnoremap <Leader>yaa ggyG''
nnoremap <Leader>ypG VGyGp

" Delete
nnoremap <Leader>dif j<cmd>foldclose<cr>kd1j

" Delete current file
nnoremap <Leader>rm <cmd>call delete(expand('%'))<bar>b#<bar>bd#<cr>

" Close current buffer
nnoremap <Leader>bd <cmd>b#<bar>bd#<CR>

" Git
nnoremap <Leader>gdh <cmd>diffget //2<cr>
nnoremap <Leader>gdl <cmd>diffget //3<cr>
nnoremap <Leader>gpn 6kyyGpi

" Find
nnoremap <Leader>fp /<C-r>0<cr>
nnoremap <Leader>fiw yiw/<C-r>0<cr>
nnoremap <Leader>fn <cmd>Navbuddy<cr>

" Edit file
nnoremap <Leader>ze <cmd>e ~/.zshrc<cr>

" Center focused line
let line_moved_commands = ['u', 'e', '<c-r>', 'n', 'N', 'G', 'w', 'b', '``']
for cmd in line_moved_commands
  execute 'nmap <silent> '.cmd.' '.cmd.'zz'
  execute 'vmap <silent> '.cmd.' '.cmd.'zz'
endfor

vmap <silent> j jzz
vmap <silent> k kzz
cmap <expr> <cr> getcmdtype() =~ '^[/?]$' ? '<cr>zz' : '<cr>'

nnoremap <Leader>zr <cmd>res 13<cr>
