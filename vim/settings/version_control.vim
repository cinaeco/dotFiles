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
nnoremap <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Git commands with Fugitive
nnoremap <silent> <Leader>gc :Gcommit -v<CR>
nnoremap <silent> <Leader>gl :Glog<CR><CR>
nnoremap <silent> <Leader>gap :Git add -p<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
