if exists('g:loaded_ctrlp_jazzradio') && g:loaded_ctrlp_jazzradio
  finish
endif
let g:loaded_ctrlp_jazzradio = 1

let s:jazzradio_var = {
\  'init':   'ctrlp#jazzradio#init()',
\  'exit':   'ctrlp#jazzradio#exit()',
\  'accept': 'ctrlp#jazzradio#accept',
\  'lname':  'jazzradio',
\  'sname':  'jazzradio',
\  'type':   'feed',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:jazzradio_var)
else
  let g:ctrlp_ext_vars = [s:jazzradio_var]
endif

function! ctrlp#jazzradio#init()
  let s:list = jazzradio#read_cache()
  return map(keys(s:list), 's:list[v:val]["name"] . " - " . s:list[v:val]["desc"] . " [" . s:list[v:val]["id"] . "]"')
endfunc

function! ctrlp#jazzradio#accept(mode, str)
  call ctrlp#exit()
  let id = matchstr(a:str, '\[\zs.\+\ze\]$')
  if len(id)
    call jazzradio#play(id)
  endif
endfunction

function! ctrlp#jazzradio#exit()
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#jazzradio#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
