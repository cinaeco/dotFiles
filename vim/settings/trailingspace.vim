" Trailing Space - Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"
"   cinaeco/dotfiles Trailing space removal
"
"   Taken from spf13-vim
"
" }}}

" Remove trailing spaces before save {{{
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
" }}}
