" Fugitive Autocommands
if has("autocmd")
  " Fugitive - Go up to previous tree object while exploring git tree with '..'
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  " Fugitive - Delete buffers when they are not active
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" Search for conflict markers
nnoremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Git commands with Fugitive
nnoremap <silent> <leader>gc :Gcommit -v<CR>
nnoremap <silent> <leader>gl :Glog<CR><CR>
nnoremap <silent> <leader>gap :Git add -p<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
