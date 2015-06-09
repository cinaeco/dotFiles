" Backspace to clear current search (and stop highlighting)
nnoremap <silent> <backspace> :call ClearSearch()<CR>

function! ClearSearch()
  if (@/ != "")
    let @/=""
    redraw
  endif
endfunction
