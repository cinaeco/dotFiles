if v:version >= 704 || (v:version == 703 && has('insert_expand') && has('menu'))
  " Suggested settings.
  " Use menus always. No messages for insert mode completion menu.
  set completeopt+=menu,menuone
  if v:version >= 704 && has('patch314')
    set shortmess+=c
  endif

  " Automatic Completion for 7.4+.
  if v:version >= 704 && has('patch775')
    set completeopt+=noinsert,noselect
    let g:mucomplete#enable_auto_at_startup = 1
  endif
endif
