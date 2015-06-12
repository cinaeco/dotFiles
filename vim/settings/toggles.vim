" Toggle paste mode - no autoindenting of pasted material
nnoremap <silent> <F2> :set paste! paste?<CR>
set pastetoggle=<F2>

" Toggle text wrap
nnoremap <silent> <F3> :set wrap! wrap?<CR>

" Toggle visible whitespace characters
nnoremap <silent> <Leader>l :set list! list?<CR>

" Toggle scrollbind for moving multiple splits in sync together
nnoremap <silent> <Leader>s :set scrollbind! scrollbind?<CR>
