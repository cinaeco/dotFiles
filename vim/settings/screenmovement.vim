" Screen Movement - Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"
"   cinaeco/dotfiles Screen Movement shortcuts
"
"   Taken from spf13-vim
"
" }}}

" Freedom of movement in visual block mode
set virtualedit=block

" Smart way to move between windows, with vertical maximisation (spf13-vim).
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-l> <C-w>l<C-w>_
map <C-h> <C-w>h<C-w>_

" Smart way to move between windows, without vertical maximisation.
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-h> <C-w>h
"noremap <C-l> <C-w>l

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
