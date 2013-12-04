" Toggle Commenting out lines with NERDCommenter
nnoremap <silent> <leader>, :call NERDComment("n", "toggle")<CR>
vnoremap <silent> <leader>, <ESC>:call NERDComment("x", "toggle")<CR>
