" Template for shell scripts.
" Removes comments after line 1, places cursor at end of file.
autocmd BufNewFile *.sh 0r ~/dotfiles/vim/templates/bashscript | silent 2,$ g/^#/d | normal G

" Make shell scripts executable on save.
autocmd BufWritePost *.sh if getline(1) =~ "^#!/bin/" | silent !chmod +x <afile>
