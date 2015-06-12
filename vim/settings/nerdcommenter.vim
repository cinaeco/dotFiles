" Toggle Commenting out lines with NERDCommenter
nnoremap <silent> <Leader>, :call NERDComment("n", "toggle")<CR>
vnoremap <silent> <Leader>, <Esc>:call NERDComment("x", "toggle")<CR>
