" use faster search tools if available
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
elseif executable('ack')
  set grepprg=ack\ --with-filename\ --nocolor\ --nogroup\ --column
elseif executable('ack-grep')
  set grepprg=ack-grep\ --with-filename\ --nocolor\ --nogroup\ --column
endif

" don't display ack/grep terminal output. NOTE: not reliable
" https://github.com/mileszs/ack.vim/issues/18
"set shellpipe=&>

" EasyGrep settings.
let g:EasyGrepCommand = 1            " Default to grepprg instead of vimgrep.
let g:EasyGrepRecursive = 1
let g:EasyGrepReplaceWindowMode = 2  " `Replace` in same window, not tabs/splits
let g:EasyGrepFilesToExclude=".git"  " Exclude dirs for `ack` and `grep`
let g:EasyGrepRoot = "search:.git,.hg,.svn"  " Repo-aware when possible.
