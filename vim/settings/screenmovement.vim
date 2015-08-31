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

" Make movements operate on 1 screen line in wrap mode
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
xnoremap <silent> <expr> j ScreenMovement("j")
xnoremap <silent> <expr> k ScreenMovement("k")
xnoremap <silent> <expr> 0 ScreenMovement("0")
xnoremap <silent> <expr> ^ ScreenMovement("^")
xnoremap <silent> <expr> $ ScreenMovement("$")

function! ScreenMovement(movement)
  if &wrap
    return 'g' . a:movement
  else
    return a:movement
  endif
endfunction
