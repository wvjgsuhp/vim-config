let g:python3_host_prog = $HOME . '/.config/nvim/env/bin/python3'

set clipboard+=unnamedplus     " Yank without explicit registration

" Statusline theme
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

let mapleader = ' '

set clipboard+=unnamedplus     " Yank without explicit registration
set showcmd
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set tabstop=2 shiftwidth=2 expandtab

" fzf x ag
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path="0;33"', <bang>0)

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
noremap <Leader>0 <cmd>tablast<cr>

" Jump to the beginning/end of a line
noremap <Leader>h ^
noremap <Leader>l $

" Open terminal
noremap <Leader>z <cmd>terminal<cr>i
noremap <Leader>zj <cmd>split<cr><bar><cmd>terminal<cr>13<c-w>_i
noremap <Leader>zl <cmd>vsplit<cr><bar><cmd>terminal<cr>i
noremap <Leader>ez <cmd>TmuxNavigateDown<cr><cmd>TmuxNavigateLeft<cr>i

" Preview markdown
noremap <Leader>mp <cmd>term glow %<cr>

" Discard all changes
noremap <Leader>q <cmd>e!<cr>

" Open previous file
noremap <Leader>b <c-^><cr>

" Fix incorrect highlight
noremap <Leader>ffs <cmd>colorscheme github<cr>

lua << EOF
local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
EOF

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
augroup END

" Yank filename
nnoremap <Leader>yfn :let @+=expand("%")<CR>:echo 'Yanked filename'<CR>
nnoremap <Leader>yrp :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>yap :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>
