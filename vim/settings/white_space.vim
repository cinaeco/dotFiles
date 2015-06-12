" Remove trailing spaces before save
if has("autocmd")
  " Are there really any files we care about that Need trailing white space?
  "autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml
  autocmd BufWritePre * call StripTrailingWhitespace()

  function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endfunction

endif

" Add extra lines up and down
nnoremap <Leader>j o<Esc>k
nnoremap <Leader>k O<Esc>j

" Convert tabs to spaces
nnoremap <silent> <Leader><Tab> :%s/<Tab>/  /g<CR>
