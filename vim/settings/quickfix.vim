if has("autocmd")

  " Open quickfix window after any grep invocation (Glog and Ggrep). {{{
  autocmd QuickFixCmdPost *grep* cwindow |
        \ setlocal nocursorline |
        \ let g:qfix_win = bufnr("$") |
        \ call MapQfPrevNext()
  " }}}

endif
