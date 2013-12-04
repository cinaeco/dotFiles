" Toggle keyboard layout
nnoremap <silent> <leader><space> :call CycleKeymap()<CR>

function! CycleKeymap()
  if has('keymap')
    if (&keymap == '')
      set keymap=colemak
      echo 'Colemak keymap selected'
    elseif (&keymap == 'colemak')
      set keymap=dvorak
      echo 'Dvorak keymap selected'
    else
      set keymap=
      echo 'Qwerty keymap selected'
    endif
  else
    echo 'Keymaps not supported'
  endif
endfunction
