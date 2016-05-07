" Toggle Commenting out lines with NERDCommenter.
nnoremap <silent> cc :call NERDComment("n", "toggle")<CR>
vnoremap <silent> cc <Esc>:call NERDComment("x", "toggle")<CR>

" Add PHP docblocks.
let g:pdv_template_dir = expand('~/dotfiles/vim/plugged/pdv/templates')
map <Leader>b :call pdv#DocumentCurrentLine()<CR>
