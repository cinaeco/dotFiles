" Quickfix - Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"
"   cinaeco/dotfiles Quickfix Maps and Behaviors
"
"   Some personal conventions:
"    - 'q' to close quickfix and location list windows.
"    - 'o' to open quickfix and location list entries.
"      (not all plugins have these maps)
"    - <TAB> and <BSLASH> for previous and next entries, so long as quickfix
"    is open.
"      (maps are cleared when quickfix is closed)
"    - quickfix should open after any grep invocation e.g. :Glog
"      (particularly for fugitive - tpope refuses this as default behaviour)
"
"   TODO:
"    Perhaps this could be some less arbitrary rule?
"
" }}}

if has("autocmd")

  " Quickfix Buffer remaps, 'q' and 'o'. {{{
  "  - `q` to close qf buffer.
  "  - `o` to open location entry under cursor.
  autocmd FileType qf nnoremap <silent> <buffer> q :ccl<CR>:lcl<CR>
  autocmd FileType qf nnoremap <silent> <buffer> o <CR>
  " }}}

  " Global maps on qf window open, '<TAB>' and '<BSLASH>'. {{{
  "  - `<TAB>` and `<BSLASH>` for going to previous and next entry
  "  - unmaps when qf buffer is closed.
  autocmd BufWinEnter quickfix
        \ setlocal nocursorline |
        \ let g:qfix_win = bufnr("$") |
        \ call MapQfPrevNext()
  " }}}

  " Global map removal on qf window close. {{{
  autocmd BufWinLeave *
        \ if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win |
        \   unlet! g:qfix_win |
        \   call UnmapQfPrefNext() |
        \ endif
  " }}}

  " Open quickfix window after any grep invocation (Glog and Ggrep). {{{
  autocmd QuickFixCmdPost *grep* cwindow |
        \ setlocal nocursorline |
        \ let g:qfix_win = bufnr("$") |
        \ call MapQfPrevNext()
  " }}}

  " <TAB> and <BSLASH> map adding helper. {{{
  function! MapQfPrevNext()
    exec "nmap <silent> <tab> :cprev<CR>"
    exec "nmap <silent> <bslash> :cnext<CR>"
  endfunction
  " }}}

  " <TAB> and <BSLASH> map removal helper. {{{
  function! UnmapQfPrefNext()
    exec "nunmap <tab>"
    exec "nunmap <bslash>"
  endfunction
  " }}}

endif
