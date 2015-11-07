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

" Git commands with Fugitive
nmap <silent> <Leader>gc :Gcommit -v<CR>
"nmap <silent> <Leader>gl :Glog<CR><CR>
nmap <silent> <Leader>gl :BCommits<CR>
nmap <silent> <Leader>gap :Git add -p<CR>
nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gd :Gdiff<CR>
nmap <silent> <Leader>gb :Gblame<CR>
nmap <silent> <Leader>grbc :Git rebase --continue<CR>
