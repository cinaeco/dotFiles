" Toggle Commenting out lines with NERDCommenter
nnoremap <silent> cc :call NERDComment("n", "toggle")<CR>
vnoremap <silent> cc <Esc>:call NERDComment("x", "toggle")<CR>
