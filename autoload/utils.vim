function! utils#startsWith(longer, shorter)
  return a:longer[0:len(a:shorter)-1] ==# a:shorter
endfunction

function! utils#isTerminal()
  return utils#startsWith(expand("%"), "term://")
endfunction
