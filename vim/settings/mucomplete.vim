" Suggested settings.
" Use menus always. No messages for insert mode completion menu.
set completeopt+=menu,menuone
set shortmess+=c

" Automatic Completion for 7.4+.
if v:version >= 704
  set completeopt+=noinsert,noselect
  let g:mucomplete#enable_auto_at_startup = 1
endif
