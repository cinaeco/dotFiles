" Highlight trailing whitespace, except where still typing
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Remove trailing spaces before save
autocmd BufWritePre * call StripTrailingWhitespace()
function! StripTrailingWhitespace()
  " Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do it.
  %s/\s\+$//e
  " Restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Add extra lines up and down
nnoremap <Leader>j o<Esc>k
nnoremap <Leader>k O<Esc>j

" Convert tabs to spaces
nnoremap <silent> <Leader><Tab> :%s/<Tab>/  /g<CR>
