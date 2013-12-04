" use ack for grepping if available
if executable('ack-grep')
  set grepprg=ack-grep\ --with-filename\ --nocolor\ --nogroup
elseif executable('ack')
  set grepprg=ack\ --with-filename\ --nocolor\ --nogroup
endif
" don't display ack/grep terminal output. NOTE: not reliable
" https://github.com/mileszs/ack.vim/issues/18
set shellpipe=&>

let g:EasyGrepRecursive = 1
let g:EasyGrepHighlightQfMatches = 1
let g:EasyGrepReplaceWindowMode = 2  " Edit and save in place (no new tabs/splits)
