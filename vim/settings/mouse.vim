""""""""
"" UI - Mouse & Cursor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The following two settings are related to how vim reacts to the incoming $TERM
" value from either the terminal emulator (e.g. iTerm2) or tmux. In the best
" case, both of these should be set to xterm-256color. This will result in vim
" reacting with the settings below:
"set ttymouse=xterm2 " Needed to allow mouse support to resize windows
"set ttyfast " Allows for instantaneous refresh when using the mouse to select

" Mouse support enabled.
set mouse=a

" Toggle mouse support.
nnoremap <silent> <Leader>m :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo 'Mouse usage disabled'
  else
    set mouse=a
    echo 'Mouse usage enabled'
  endif
endfunction
