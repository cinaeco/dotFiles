if has("autocmd")

  " Restore Position
  " Based on the last-position mark '"'. Go to it if it is not the first line,
  " and if it is valid i.e. within the number of lines in the file.
  " From `:help line()`
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Git Commit Exception
  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

endif
