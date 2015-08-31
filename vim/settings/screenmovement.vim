" Freedom of movement in visual block mode
set virtualedit=block

" Smart way to move between windows
" Enchancing these mapping with vertical maximisation (<C-w>_) is interesting
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier horizontal scrolling
map zl zL
map zh zH

" Easier jumping to beginning and end of line
map H ^
map L $

" Move according to the screen when wrapped
function! ScreenMove(move)
  if &wrap
    return 'g' . a:move
  else
    return a:move
  endif
endfunction

" Map screen moves in normal, operator-pending and visual (but not select) modes
function! MapScreenMove(move)
  for mapmode in ['n', 'o', 'x']
    execute mapmode."noremap <silent> <expr>" a:move 'ScreenMove("'.a:move.'")'
  endfor
endfunction

call MapScreenMove("j")
call MapScreenMove("k")
call MapScreenMove("0")
call MapScreenMove("^")
call MapScreenMove("$")
