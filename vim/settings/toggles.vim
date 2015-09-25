" Toggle paste mode - no autoindenting of pasted material
nnoremap <silent> <F2> :set paste! paste?<CR>
set pastetoggle=<F2>

" Toggle line numbers
nnoremap <silent> <Leader>n :set number! relativenumber! number?<CR>

" Toggle Undotree
nnoremap <silent> <Leader>u :UndotreeToggle<CR>

" Toggle Tagabar
nnoremap <silent> <Leader>t :TagbarToggle<CR>
" Close tagbar after we go to selection
let g:tagbar_autoclose = 1
