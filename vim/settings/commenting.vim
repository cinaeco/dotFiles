" Toggle Commenting out lines with NERDCommenter
nnoremap <silent> cc :call NERDComment("n", "toggle")<CR>
vnoremap <silent> cc <Esc>:call NERDComment("x", "toggle")<CR>

let g:pdv_template_dir = expand('~/.vim/plugged/pdv/templates')
map <Leader>b :call pdv#DocumentCurrentLine()<CR>
